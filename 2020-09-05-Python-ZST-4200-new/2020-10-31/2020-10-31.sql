


Error while opening connection
 - ERR_04110_CANNOT_CONNECT_TO_SERVER Cannot connect to the server: Connection refused: no further information
org.apache.directory.ldap.client.api.exception.InvalidConnectionException: ERR_04110_CANNOT_CONNECT_TO_SERVER Cannot connect to the server: Connection refused: no further information
	at org.apache.directory.ldap.client.api.LdapNetworkConnection.close(LdapNetworkConnection.java:756)
	at org.apache.directory.ldap.client.api.LdapNetworkConnection.connect(LdapNetworkConnection.java:951)
	at org.apache.directory.studio.connection.core.io.api.DirectoryApiConnectionWrapper$1.run(DirectoryApiConnectionWrapper.java:234)
	at org.apache.directory.studio.connection.core.io.api.DirectoryApiConnectionWrapper.runAndMonitor(DirectoryApiConnectionWrapper.java:1277)
	at org.apache.directory.studio.connection.core.io.api.DirectoryApiConnectionWrapper.doConnect(DirectoryApiConnectionWrapper.java:268)
	at org.apache.directory.studio.connection.core.io.api.DirectoryApiConnectionWrapper.connect(DirectoryApiConnectionWrapper.java:159)
	at org.apache.directory.studio.connection.core.jobs.OpenConnectionsRunnable.run(OpenConnectionsRunnable.java:111)
	at org.apache.directory.studio.connection.core.jobs.StudioConnectionJob.run(StudioConnectionJob.java:109)
	at org.eclipse.core.internal.jobs.Worker.run(Worker.java:63)
Caused by: java.net.ConnectException: Connection refused: no further information
	at sun.nio.ch.SocketChannelImpl.checkConnect(Native Method)
	at sun.nio.ch.SocketChannelImpl.finishConnect(Unknown Source)
	at org.apache.mina.transport.socket.nio.NioSocketConnector.finishConnect(NioSocketConnector.java:223)
	at org.apache.mina.transport.socket.nio.NioSocketConnector.finishConnect(NioSocketConnector.java:47)
	at org.apache.mina.core.polling.AbstractPollingIoConnector$Connector.processConnections(AbstractPollingIoConnector.java:571)
	at org.apache.mina.core.polling.AbstractPollingIoConnector$Connector.run(AbstractPollingIoConnector.java:456)
	at org.apache.mina.util.NamePreservingRunnable.run(NamePreservingRunnable.java:64)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(Unknown Source)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(Unknown Source)
	at java.lang.Thread.run(Unknown Source)

ERR_04110_CANNOT_CONNECT_TO_SERVER Cannot connect to the server: Connection refused: no further information


