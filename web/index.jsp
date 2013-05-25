<!--
Copyright (C) 2013 Google Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->
<%@ page import="com.google.api.client.auth.oauth2.Credential" %>
<%@ page import="com.google.api.services.mirror.model.Contact" %>
<%@ page import="com.google.glassware.MirrorClient" %>
<%@ page import="com.google.glassware.WebUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.api.services.mirror.model.TimelineItem" %>
<%@ page import="com.google.api.services.mirror.model.Subscription" %>
<%@ page import="com.google.api.services.mirror.model.Attachment" %>
<%@ page import="com.mitchbarry.glassware.magiccrystalprism.MainServlet" %>
<%@ page import="com.google.glassware.AuthUtil" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>
<%
    String userId = com.google.glassware.AuthUtil.getUserId(request);
    String appBaseUrl = WebUtil.buildUrl(request, "/");
    Credential credential = com.google.glassware.AuthUtil.getCredential(userId);
    Contact contact = MirrorClient.getContact(credential, MainServlet.CONTACT_NAME);
%>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Magic Crystal Prism</title>
    <link href="/static/bootstrap/css/bootstrap.min.css" rel="stylesheet"
          media="screen">
    <link href="/static/bootstrap/css/custom.css" rel="stylesheet"
          media="screen">

    <style>
        .button-icon {
            max-width: 75px;
        }

        .tile {
            border-left: 1px solid #444;
            padding: 5px;
            list-style: none;
        }

        .btn {
            width: 100%;
        }
    </style>
</head>
<body>
<div class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container">
            <a class="brand" href="#">Magic Crystal Prism</a>

            <div class="nav-collapse collapse">
                <form class="navbar-form pull-right" action="/signout" method="post">
                    <button type="submit" class="btn">Sign out</button>
                </form>
            </div>
            <!--/.nav-collapse -->
        </div>
    </div>
</div>

<div class="container">

    <!-- Main hero unit for a primary marketing message or call to action -->
    <div class="hero-unit">
        <h1>Ask away ... </h1>
        <br/>

        <p>
            An exhilarating way to get a <strong>yes/no</strong> answer to your most important questions!
            Let the Magic Crystal Prism on your very own face help you out! Simply click the button below
            to get started!
        </p>

        <% String flash = WebUtil.getClearFlash(request);
            if (flash != null) { %>
            <p class="label label-info"><%= flash %></p>
        <% } %>

        <p style="width:55%;">
            <% Boolean installed = AuthUtil.hasUserInstalled(request, userId);
            if (!installed) {
            %>
                <form action="<%= WebUtil.buildUrl(request, "/main") %>" method="post" style="display: inline;">
                    <input type="hidden" name="operation" value="userInstall">
                    <button class="btnGreen" type="submit">Install Glassware</button>
                </form>
            <% } else { %>
                <form action="<%= WebUtil.buildUrl(request, "/main") %>" method="post" style="display: inline;">
                    <input type="hidden" name="operation" value="userUninstall">
                    <button class="btnRed" type="submit">Uninstall Glassware</button>
                </form>
            <% } %>
        </p>
        <div style="clear:both;"></div>
    </div>

    <!-- Example row of columns -->
    <div class="row">
        <div class="span4">
            <h2>Try it out!</h2>

            <p>Test the true power of your own personal Magic Crystal Prism right now!
                Why wait to try it with your voice? Your fingers are itching, too!</p>


            <form action="<%= WebUtil.buildUrl(request, "/main") %>" method="post">
                <input type="hidden" name="operation" value="insertItem">
                <textarea name="message">Should I go for a run?</textarea><br/>
                <button class="btn" type="submit">Ask Away</button>
            </form>

            <!--
            <form action="<%= WebUtil.buildUrl(request, "/main") %>" method="post">
                <input type="hidden" name="operation" value="insertItem">
                <input type="hidden" name="message" value="Chipotle says 'hi'!">
                <input type="hidden" name="imageUrl" value="<%= appBaseUrl +
               "static/images/chipotle-tube-640x360.jpg" %>">
                <input type="hidden" name="contentType" value="image/jpeg">

                <button class="btn" type="submit">A picture
                    <img class="button-icon" src="<%= appBaseUrl +
               "static/images/chipotle-tube-640x360.jpg" %>">
                </button>
            </form>
            <form action="<%= WebUtil.buildUrl(request, "/main") %>" method="post">
                <input type="hidden" name="operation" value="insertItemWithAction">
                <button class="btn" type="submit">A card you can reply to</button>
            </form>
            <hr>
            <form action="<%= WebUtil.buildUrl(request, "/main") %>" method="post">
                <input type="hidden" name="operation" value="insertItemAllUsers">
                <button class="btn" type="submit">A card to all users</button>
            </form>
            -->

        </div>

        <div class="span4">
            <h2>Manage Your Prism Access</h2>

            <p>
                Don't want Magic Crystal Prism as a contact on your Glass?
                Add/Remove the contact here! If at any time you want to add it back, simply come
                back here to adjust your settings.
            </p>
            <% if (contact == null) { %>
            <form class="span3" action="<%= WebUtil.buildUrl(request, "/main") %>"
                  method="post">
                <input type="hidden" name="operation" value="insertContact">
                <input type="hidden" name="iconUrl" value="<%= appBaseUrl +
               "static/images/chipotle-tube-640x360.jpg" %>">
                <input type="hidden" name="name"
                       value="<%= MainServlet.CONTACT_NAME %>">
                <button class="btn" type="submit">Insert Magic Crystal Prism Contact
                </button>
            </form>
            <% } else { %>
            <form class="span3" action="<%= WebUtil.buildUrl(request, "/main") %>"
                  method="post">
                <input type="hidden" name="operation" value="deleteContact">
                <input type="hidden" name="id" value="<%= MainServlet.CONTACT_NAME %>">
                <button class="btn" type="submit">Delete Magic Crystal Prism Contact
                </button>
            </form>
            <% } %>
        </div>

        <div class="span4">
            <h2>Updates</h2>

            <p>
            <ul>
                <li>2013-05-24</li>
                <li>
                    <ul>
                        <li>Item 1</li>
                    </ul>
                </li>
                <li>2013-05-25</li>
                <li>
                    <ul>
                        <li>Item 1</li>
                        <li>Item 2</li>
                    </ul>
                </li>
            </ul>
            </p>
        </div>
    </div>
</div>

<script
        src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
