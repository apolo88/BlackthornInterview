# Salesforce Blackthorn Interview

Repository Owner: Alejandro Spinelli

## Concerns and solution explanation

- The code was deployed, developed and tested in an empty Salesforce playground. All the test methods passed succesfully.
- I was forced to modify the PubSubServiceTest class in line 102 because the insert of the Lead was failing in my Salesforce playground due to the Company required field missing. I ended up setting a 'Test' value on the Company field.
- Regarding the PubSub solution, I considered using a Map (PubService.cls line 7) instead of a regular list to store the IHandleMessages instances segmented by channel, the decision I took this approach was to improve the performance on the emit method doing less iterations in the loop and executing the handlemessage method only on the necessary instances, instead of looping all instances and trying to execute the handleMessage method in all of them. With this map approach, probably the performance on the subscribe and unsubscribe methods is not so efficient compared to the regular list approach, but I consider that the frequency on the call to the emit method is gonna be much higher than the subscribe and unsubscribe methods, so will end up having a better overall performance.
- Based on the previous point it seems that probably the argument "channel" on the handleMessage method inside the IHandleMessages.cls doesn't have sense anymore and could be removed (could only make sense for debug and notifications purpose about the current channel), but I didn't want to modify the structure of the code due to the exercise statement.
