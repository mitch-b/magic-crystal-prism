Magic Crystal Prism
========================

Source code for Glassware (server-side service for Google Glass application) which
will provide a response based on user text input.

## Getting Started

1. Install [Google App Engine v1.8.0](https://code.google.com/p/googleappengine/downloads/list?q=java+1.8)

2. Ensure you have JDK 1.6

3. Navigate to repository via Command Prompt or Terminal and run Maven

```bash
mvn clean process-sources
```

4. Start AppEngine local development server (or run via Eclipse/IntelliJ Idea)

```bash
dev_appserver.sh ./web/
```

## More Information

This application is built from [Google Mirror API's Quickstart for Java](https://github.com/googleglass/mirror-quickstart-java)

The documentation for this quickstart is maintained on developers.google.com.
Please see here for more information:
https://developers.google.com/glass/quickstart/java
