// License: Apache 2.0. See LICENSE file in root directory.
// Copyright(c) 2015 Intel Corporation. All Rights Reserved.

#include <librealsense/rs.hpp>
#include "example.hpp"

#include <chrono>
#include <vector>
#include <sstream>
#include <iostream>
#include <algorithm>
#include <cmath> //<math.h> //sqrt
#include <unistd.h> //usleep
#include <fstream> //to write to a text file


struct state { double yaw, pitch, lastX, lastY; bool ml; std::vector<rs::stream> tex_streams; int index; rs::device * dev; };
using namespace std;

int main(int argc, char * argv[]) try
{
    rs::log_to_console(rs::log_severity::warn);
    //rs::log_to_file(rs::log_severity::debug, "librealsense.log");

    rs::context ctx;
    if(ctx.get_device_count() == 0) throw std::runtime_error("No device detected. Is it plugged in?");
    rs::device & dev = *ctx.get_device(0);

    dev.enable_stream(rs::stream::depth, rs::preset::best_quality);
    dev.enable_stream(rs::stream::color, rs::preset::best_quality);
    //dev.enable_stream(rs::stream::infrared, rs::preset::best_quality);
    try { dev.enable_stream(rs::stream::infrared2, rs::preset::best_quality); } catch(...) {}
    dev.start();
    
    state app_state = {0, 0, 0, 0, false, {rs::stream::color, rs::stream::depth, rs::stream::infrared}, 0, &dev};
    if(dev.is_stream_enabled(rs::stream::infrared2)) app_state.tex_streams.push_back(rs::stream::infrared2);

    texture_buffer tex;

    ofstream file;
    file.open("img.csv", ios::trunc | ios::out);
    if (file.is_open()) std::cout << "HELP" << "\n";

    int frames = 0, n=0; float time, fps = 0, microseconds = 0, dt = 0;
    auto t0 = std::chrono::high_resolution_clock::now();
    while (frames<2)//(true) //(!glfwWindowShouldClose(win))
    {
        //dev.poll_for_frames(); //glfwPollEvents();
        if(dev.is_streaming()) dev.wait_for_frames();

        auto t1 = std::chrono::high_resolution_clock::now();
        time += std::chrono::duration<float>(t1-t0).count();
        t0 = t1;
        ++frames;
        /*if(time > 0.5f)
        {
            fps = frames / time;
            frames = 0;
            time = 0;
        }*/
/*
        if(dev.is_streaming()) dev.wait_for_frames();
        auto t1 = std::chrono::high_resolution_clock::now();
        microseconds = std::chrono::duration_cast<std::chrono::microseconds>(t1-t0).count();
        dt = (float)(microseconds)/1000000.0;
        time[n+1] = time[n] + dt;
        t0 = t1;
        ++frames;
        ++n;*/

         //std::cout << "HELP" << endl;

        const rs::stream tex_stream = app_state.tex_streams[app_state.index];
        const rs::extrinsics extrin = dev.get_extrinsics(rs::stream::depth, tex_stream);
        const rs::intrinsics depth_intrin = dev.get_stream_intrinsics(rs::stream::depth);
        const rs::intrinsics tex_intrin = dev.get_stream_intrinsics(tex_stream);
        bool identical = depth_intrin == tex_intrin && extrin.is_identity();

        auto points = reinterpret_cast<const rs::float3 *>(dev.get_frame_data(rs::stream::points));
        auto depth = reinterpret_cast<const uint16_t *>(dev.get_frame_data(rs::stream::depth));
        
        float dist;
        /*float pvect[5];
        float min_dist = 0.7;
        float max_dist = 10;*/
        //int ww = 628;
        //float filterfish = 0.2;
        usleep(20000);
        float img[3][293904];
       // int reso = 293904;
        int i = 1;

        //std::cout << "Before File" << endl;



        for(int y=0; y<depth_intrin.height; ++y)
        {
            for(int x=0; x<depth_intrin.width; ++x)
            {
                if((points->z))// && i<reso) //if(uint16_t d = *depth++)
                {
                    dist = sqrt((points->x)*(points->x)+(points->y)*(points->y)+(points->z)*(points->z));
                    //img[i-1][0]=dist;
                    //std::cout << dist << endl;
                    img[0][i-1] = points->x;
                    img[1][i-1] = points->y;
                    img[2][i-1] = points->z;

                    //std::cout << "If Statement" << endl;

                    //Min distance algorithm
                    dist = sqrt((points->x)*(points->x) + (points->y)*(points->y) + (points->z)*(points->z));
                    //std::cout << time << endl;
                    /*if((dist>min_dist) && dist<max_dist)// && ((abs((points-2))->z) - (points->z)) < filterfish && ((abs((points-ww))->z) - (points->z)) < filterfish)
                    {
                        max_dist = dist;
                        pvect[0] = time;
                        pvect[1] = points->x;
                        pvect[2] = points->y;
                        pvect[3] = points->z;
                        pvect[4] = dist;
                    }*/

                }

                 file << img[0][i-1] << '\t' << img[1][i-1] << '\t' << img[2][i-1] << '\n';
                ++points;
                ++i;
            }
        }
        //file << (float) pvect[0] << '\t' << (float) pvect[1] << '\t' << (float) pvect[2] << '\t' << (float) pvect[3] << '\t' << (float) pvect[4] << '\n';

    }

    file.close();
    return EXIT_SUCCESS;
    //std::cout << "File Out" << endl;

}

catch(const rs::error & e)
{
    std::cerr << "RealSense error calling " << e.get_failed_function() << "(" << e.get_failed_args() << "):\n    " << e.what() << std::endl;
    return EXIT_FAILURE;
}
catch(const std::exception & e)
{
    std::cerr << e.what() << std::endl;
    return EXIT_FAILURE;
}
