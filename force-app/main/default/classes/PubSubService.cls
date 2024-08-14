/**
 * @description A simple Pub/Sub pattern implementation
 */
public with sharing class PubSubService {
    
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
        if(String.isNotBlank(channel) && implementationsByChannel.containsKey(channel)){
            for(IHandleMessages implementation : implementationsByChannel.get(channel)){
                implementation.handleMessage(channel, data);
            }
        }
    }
}