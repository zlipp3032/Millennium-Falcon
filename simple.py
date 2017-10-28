from dronekit import connect,VehicleMode, LocationGlobalRelative, LocationGlobal
import sys
import time
import argparse
from pymavlink import mavutil

# Setup option parsing to get connection string
parser = argparse.ArgumentParser(description='Commands vehicle using simple.')
parser.add_argument('--connect',
                      help="Vehicle connect target string. If not specified, SITL automatically started and used")
args = parser.parse_args()
connection_string = args.connect
sitl = None

# Start SITL if no connection string specifiied
if not connection_string:
    import dronekit_sitl
    sitl = dronekit_sitl.start_default()
    connection_string = sitl.connection_string()

# Connect to UDP endpoint (and wait for defualt attributes to accumulate)
#target = sys.argv[1] if len(sys.argv) >= 2 else 'udpin:0.0.0.0:14550'
#print 'Connecting to ' + target + '...'
#vehicle = connect(target, wait_ready=True)
print '\nConnecting to vehicle on: %s' % connection_string
vehicle = connect(connection_string, wait_ready = True, baud=57600) #230400 or 115000 or 250000)

def arm_and_takeoff(aTargetAltitude):
    # Arms vehicle and fly to a target altitude and hover
    print 'Basic pre-arm checks'
    # Don't try to arm until autopilot is ready
    while not vehicle.is_armable:
        print 'Waiting for vehicle to initialize...'
        time.sleep(1)

    print 'Arming motors'
    vehicle.mode = VehicleMode("GUIDED")
    vehicle.armed = True
    
    vehicle.simple_takeoff(aTargetAltitude)

    # Wait until the vehicle reaches a safe height before processing the goto (otherwise the commancd after Vehicle.simple_takeoff will execute immediately)
    while True:
        print "Altitude: ", vehicle.location.global_relative_frame.alt
        #Break and return from function just below target altitude
        if vehicle.location.global_relative_frame.alt>=aTargetAltitude*0.95:
            print "Reached Target Altitude!"
            break
        time.sleep(10)


vehicle.armed = True # Arm motors before takeoff
time.sleep(10) # Wait 10 seconds ?
arm_and_takeoff(3) #Take off to a height of 3 meters and wait 10 seconds ---> Then next command



#vehicle.airSpeed = 3 # 3 m/s I believe are the units

#point1 = LocationGlobalRelative(x.xxxxxxx, y.yyyyyyyy, z.zzzzzzzzz)
#vehicle.simple_goto(point1)
#point2 = LocationGlobalRelative(x.xxxxxxx, y.yyyyyyyy, z.zzzzzzzzz)
#to reset the groundspeed using vehicle.simple_goto
#vehicle.simple_goto(point2, groundspeed=10) #10 m/s


# Velocity commands with respect to home location directionally
# Be sure tp set up the home location and know your bearings; update the table below before you fly
# velocity_x > 0 => fly North
# velocity_x < 0 => fly South
# velocity_y > 0 => fly East
# velocity_y < 0 => fly West
# velocity_z < 0 => ascend
# velocity_z > 0 => descend
 ###
def send_ned_velocity(velocity_x, velocity_y, velocity_z, duration):
#    """
#    Move vehicle in direction based on specified velocity vectors.
#    """
    msg = vehicle.message_factory.set_position_target_local_ned_encode( #msg = vehicle.message_factory.set_position_target_global_int_encode(
        0,       # time_boot_ms (not used)
        0, 0,    # target system, target component
        mavutil.mavlink.MAV_FRAME_LOCAL_NED, # frame
        0b0000111111000111, # type_mask (only speeds enabled)
        0, 0, 0, # x, y, z positions (not used)
        velocity_x, velocity_y, velocity_z, # x, y, z velocity in m/s
        0, 0, 0, # x, y, z acceleration (not supported yet, ignored in GCS_Mavlink)
        0, 0)    # yaw, yaw_rate (not supported yet, ignored in GCS_Mavlink)


    # send command to vehicle on 1 Hz cycle
    for x in range(0,duration):
        vehicle.send_mavlink(msg)
        time.sleep(1)

vx1 = [1, 0, 0, -1]
vy1 = [0, 0.5, 0, -0.5]
vz1 = [0, 0, -0.2, 0.2]
durate = 10
send_ned_velocity(vx1[0], vy1[0], vz1[0], durate)
print "Agent X Velocity: %s" %vehicle.velocity[0]
print "Agent Y Velocity: %s" %vehicle.velocity[1]
print "Agent Z Velocity: %s" %vehicle.velocity[2]
send_ned_velocity(vx1[1], vy1[1], vz1[1], durate)
print "Agent X Velocity: %s" %vehicle.velocity[0]
print "Agent Y Velocity: %s" %vehicle.velocity[1]
print "Agent Z Velocity: %s" %vehicle.velocity[2]
send_ned_velocity(vx1[2], vy1[2], vz1[2], durate)
print "Agent X Velocity: %s" %vehicle.velocity[0]
print "Agent Y Velocity: %s" %vehicle.velocity[1]
print "Agent Z Velocity: %s" %vehicle.velocity[2]
send_ned_velocity(vx1[3], vy1[3], vz1[3], durate)
print "Agent X Velocity: %s" %vehicle.velocity[0]
print "Agent Y Velocity: %s" %vehicle.velocity[1]
print "Agent Z Velocity: %s" %vehicle.velocity[2]
 ###

print 'Return to Launch!'
vehicle.mode = VehicleMode("RTL")

# Close vehicle object
print "Close vehicle object"
vehicle.close()

# Shut dow simuator if it was started
#if sitl is not None
#sitl.stop()



#vehicle.armed = True
