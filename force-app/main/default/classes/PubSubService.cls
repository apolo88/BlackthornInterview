/**
 * @description A simple Pub/Sub pattern implementation
 */
public with sharing class PubSubService {
    
    // Segment the implementationClasses by channel to optimize emit method
    private Map<String, List<IHandleMessages>> implementationsByChannel;

    private PubSubService() { 
        implementationsByChannel = new Map<String, List<IHandleMessages>>();
    }

    /**
     * @description A singleton for service interaction.
     */
    public static PubSubService Instance {
        get {
            if (Instance == null) {
                Instance = new PubSubService();
            }

            return Instance;
        }

        private set;
    }

    /**
     * @description Subscribes a given IHandleMessages implementation to the channels it returns.
     * @param implementation An instance of IHandleMessages.
     * @throws ArgumentNullException if implementation is null.
     */
    public void subscribe(IHandleMessages implementation) {
        // TODO: Complete this method
        
        // For each of the channels that the implementation instance was subscribed it is stored in the correct channel list
        for(String channel : implementation.getSubscribedChannels()){
            if(implementationsByChannel.containsKey(channel)){
                implementationsByChannel.get(channel).add(implementation);
            }else{
                implementationsByChannel.put(channel, new List<IHandleMessages>{implementation});
            }
        }
    }

    /**
     * @description Un-subscribes a given IHandleMessages implementation to the channels it returns.
     * @param implementation An instance of IHandleMessages.
     * @throws ArgumentNullException if implementation is null.
     */
    public void unsubscribe(IHandleMessages implementation) {
        // TODO: Complete this method
        
        // Looks for each of the channels were was subscribed and removes the instance from each of the channels
        for(String channel : implementation.getSubscribedChannels()){
            if(implementationsByChannel.containsKey(channel)){
                List<IHandleMessages> implementations = implementationsByChannel.get(channel);
                implementations.remove(implementations.indexOf(implementation));

                if(implementations.isEmpty()){
                    implementationsByChannel.remove(channel);
                }
            }
        }
    }

    /**
     * @description Emits a message to a given channel containing the specified data.
     * @param channel The channel to emit a message on.
     * @param data The data to emit.
     * @throws ArgumentNullException if channel is null.
     */
    public void emit(String channel, Object data) {
        // TODO: Complete this method

        // If the channel is contained on the map, then executes only the handlemessage of the instances subscribed to that channel
        if(String.isNotBlank(channel) && implementationsByChannel.containsKey(channel)){
            for(IHandleMessages implementation : implementationsByChannel.get(channel)){
                implementation.handleMessage(channel, data);
            }
        }
    }
}