from dronekit import connect, Vehicle, VehicleMode
import time
import math as m
from datetime import datetime, timedelta
import sys
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
vehicle = connect(connection_string, wait_ready = True)

# Parameters that are unique to self and are measured by sensors
qx = vehicle.location.global_frame.lat #vehicle.location.global_relative_frame.lat gives same value as global_frame
qy = vehicle.location.global_frame.lon #vehicle.location.global_relative_frame.lat gives same value as global_frame
qz = vehicle.location.global_relative_frame.alt #vehicle.location.global_relative_frame.lat gives value relative to the terrain, might me more accurate???
px = vehicle.velocity[0]
py = vehicle.velocity[1]
pz = vehicle.velocity[2]


print "Agent Latitude: %s" %qx
print "Agent Longitude: %s" %qy
print "Agent Global Altitude: %s" %qz
print "Agent X velocity: %s" %px
print "Agent Y velocity: %s" %py
print "Agent Z velocity: %s" %pz

# To get the other vehicle states, look in msg.content in controlCH.py I think.
# Parameters that are unique to self and are measured by sensors
qxj = vehicle.location.global_frame.lat #vehicle.location.global_relative_frame.lat gives same value as global_frame
qyj = vehicle.location.global_frame.lon #vehicle.location.global_relative_frame.lat gives same value as global_frame
qzj = vehicle.location.global_relative_frame.alt #vehicle.location.global_relative_frame.lat gives value relative to the terrain, might me more accurate???
pxj = vehicle.velocity[0]
pyj = vehicle.velocity[1]
pzj = vehicle.velocity[2]


# Gains and other set variables
Tsbar = 0.01 #Sample time
nbar = 10 # Potential number of agents?????
deltac = 1 #lower bound for flock radius
rc = 10 #communication radius rc > deltac
d = 3 # flock radius where deltac < d <= rc
alpha1 = 150 # alpha1 = (0,inf) attraction
alpha2 = 100 # alpha2 = (0,4*(alpha1+1)/(nbar*Tsbar^2)) repulsion
gamma1 = 150 # gamma1 = [0,2/Tsbar^2) leader position
gamma2 = 10 # gamma2 = [Tsbar*gamma1/2,1/Tsbar) lead velocity
beta = 19 # beta = [alpha2*Tsbar/(2*(alpha1+1)),2/(nbar*Tsbar)) and this operates best when closer to upper bound velocity consensus

#Euclidean norm using math
# EN = math.hypot(x,y) # sqrt(x*x +y*y)
# math.sqrt(x) = sqrt(x)

#This section computes the Interagent stuff
relqx = qxj - qx
relqy = qyj - qy
relqz = qzj - qz
relvx = pxj - px
relvy = pyj - py
relvz = pzj - pz

#Euclidean Norm of next position, Should we assume the heights of the CG will be the same?
qeuclid = m.sqrt(relqx*relqx + relqy*relqy + relqz+relqz)


#Esimate next position
qhatx = qx + Tsbar*px
qhaty = qy + Tsbar*py
qhatz = qz + Tsbar*pz


#Esimate neighbor next position
qhatxj = qxj + Tsbar*pxj
qhatyj = qyj + Tsbar*pyj
qhatzj = qzj + Tsbar*pzj



print "Agent Relative X Distance: %s" %relqx
print "Agent Relative Y Distance: %s" %relqy
print "Agent Relative Z Distance: %s" %relqz
print "Agent Relative X Velocity: %s" %relvx
print "Agent Relative Y Velocity: %s" %relvy
print "Agent Relative Z Velocity: %s" %relvz


# How to send velocity commands via mav to a copter
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

send_ned_velocity(0.1,0,0,10)



print 'Return to Launch!'
vehicle.mode = VehicleMode("RTL")

# Close vehicle object
print "Close vehicle object"
vehicle.close()
