Scriptname Malarkey extends Quest
{!BIND}

int property testSphereHandle = 0 auto

Function Init()
    
    Debug.Notification("The mod has been installed")
    Actor player = Game.GetPlayer()
    float[] pose = PapyrusVR.GetSkyrimDevicePosition(0)
    Debug.Notification("Pose X: " + pose[0])
    Debug.Notification("Pose Y: " + pose[1])
    Debug.Notification("Pose Z: " + pose[2])
    Debug.Notification("Player X: " + player.X)
    Debug.Notification("Player Y: " + player.Y)
    Debug.Notification("Player Z: " + player.Z)
    Debug.Notification("Registering for VR Button events!")
    PapyrusVR.RegisterForVRButtonEvents(Game.GetForm(GetFormID()))

    Debug.Notification("Testing collision spheres!")
    PapyrusVR.RegisterForVROverlapEvents(Game.GetForm(GetFormID()))

    ;25cm sphere about 25cm on top of the headset
    float[] position = PapyrusVR.Vector3(0.0, 0.25, 0.0)
    float[] rotation = PapyrusVR.Quaternion_Zero()
    testSphereHandle = PapyrusVR.RegisterLocalOverlapSphere(0.125, position, rotation, 0)
    if testSphereHandle != 0
        Debug.Notification("Registered sphere " + testSphereHandle + " correctly!")
    endIf
    Debug.Notification("The mod has finished initializing")
EndFunction

Event OnVRButtonEvent(int buttonEvent, int buttonId, int deviceId)
    Debug.Notification("Got event from device" + deviceId + " with id " + buttonEvent + " for button " + buttonId)
EndEvent

Event OnVROverlapEvent(int overlapEventType, int objectHandle, int deviceId)
    if(overlapEventType == 1)
        Debug.Notification("Device " + deviceId + " entered local overlap object with handle " + objectHandle)
    else
        Debug.Notification("Device " + deviceId + " exited local overlap object with handle " + objectHandle)
    endIf
EndEvent