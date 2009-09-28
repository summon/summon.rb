module Summon::Transport
  
  class TransportError < StandardError; end
  
  class AuthorizationError < TransportError; end
  
  class ServiceError < TransportError; end
  
  class RequestError < TransportError; end
  
  class UnknownResponseError < TransportError; end
end