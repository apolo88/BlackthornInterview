/**
 * @description An implementation of IHandleMessages which validates the passed in Lead and inserts it.
 */
public with sharing class IncomingLeadHandler implements IHandleMessages {
    @testVisible private static final String INCOMING_LEAD_CHANNEL = 'IncomingLeads';
    @testVisible private static final String INVALID_LEAD_ERROR = 'The Lead specified is invalid.';
    @testVisible private static final String CHANNEL_PARAM = 'channel';

    /**
     * @description Constructs an instance of IncomingLeadHandler.
     */
    public IncomingLeadHandler() { }

    /**
     * @description Handles a message on a subscribed channel.
     * @param channel The channel emitting the message.
     * @param data The accompanying data for the message.
     * @throws ArgumentNullException if channel is null.
     * @throws ArgumentException if the lead is missing a FirstName.
     */
    public void handleMessage(String channel, Object data) {
        // TODO: Complete this method
        
        // Null arguments validation
        ArgumentNullException.throwIfNull(channel, 'channel');
        ArgumentNullException.throwIfNull(data, 'data');
        
        // Checks if data is a Lead instance and the class instance is subscribed to the received channel
        if(String.isNotBlank(channel) && getSubscribedChannels().contains(channel) && data instanceOf Lead){
            Lead lead = (Lead)data;

            // Validates FirstName as required in the excercise explanation
            if(lead.FirstName != null){
                insert lead;
            }else{
                throw new ArgumentException(INVALID_LEAD_ERROR);
            }
        }
    }

    /**
     * @description Gets a list of channels an implementation subscribes to.
     * @return A List<String> of channel names this implementation is subscribed to.
     */
    public List<String> getSubscribedChannels() {
        // TODO: Complete this method
        return new List<String>{INCOMING_LEAD_CHANNEL};
    }
}