<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<%@ page import="ua.edu.nau.model.UniversityStructure.Institute" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    ArrayList<Institute> institutes = ((ArrayList<Institute>) request.getAttribute(Attribute.ATTR_ARRAY_LIST_INSTITUTE));
    String jsonData = ((String) request.getAttribute("json"));
%>

<html>
<head>
    <title>Calendar</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.7/angular.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.7/angular-route.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.7/angular-resource.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.7/angular-animate.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.7/angular-aria.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.7/angular-messages.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angular_material/1.1.1/angular-material.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.js"></script>

    <script src="http://ngmaterial.assets.s3.amazonaws.com/svg-assets-cache.js"></script>

    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/angular_material/1.1.0/angular-material.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,400italic">
</head>

<style>
    .card-media {
        background-color: #999999;
    }
</style>

<body ng-app="MyApp" ng-cloak="">

<md-toolbar ng-controller="ToolbarController as ctrl" md-whiteframe="4">
    <div class="md-toolbar-tools">
        <md-button class="md-icon-button" aria-label="Settings" ng-click="toggleLeft()">
            <md-icon md-svg-icon="img/icons/menu.svg"></md-icon>
        </md-button>

        <h2 flex md-truncate>{{pageTitle}}</h2>

        <div layout="column" flex="33" layout-align="center center">
            <md-menu md-position-mode="target-right target">
                <md-button aria-label="Open demo menu" class="md-icon-button" ng-click="$mdOpenMenu($event)">
                    <md-icon md-menu-origin md-svg-icon="img/icons/more_vert.svg"></md-icon>
                </md-button>
                <md-menu-content width="4">
                    <md-menu-item ng-repeat="item in [1, 2, 3]">
                        <md-button ng-click="ctrl.announceClick($index)">
                            <div layout="row" flex>
                                <p flex>Option {{item}}</p>
                                <md-icon md-menu-align-target md-svg-icon="call:portable-wifi-off"
                                         style="margin: auto 3px auto 0;"></md-icon>
                            </div>
                        </md-button>
                    </md-menu-item>
                </md-menu-content>
            </md-menu>
        </div>

    </div>
</md-toolbar>

<md-sidenav class="md-sidenav-left" md-component-id="left" md-whiteframe="4">
    <md-toolbar class="md-tall" layout="column" layout-align="end none" md-whiteframe="4">
        <div class="md-toolbar-tools" layout="column" layout-align="end start">
            <div class=".md-title">Святненко Роман</div>
            <div class=".md-subhead">roman@gmail.com</div>
        </div>
    </md-toolbar>

    <md-content layout-margin>
        <p>
            This sidenav is not showing any backdrop, where users can click on it, to close the sidenav.
        </p>
    </md-content>
</md-sidenav>

<div layout="row" flex layout-wrap ng-controller="InstituteCardController" class='md-padding'>
    <div flex="33" flex-xs="100" flex-gt-xs="50" layout="column" ng-repeat="institute in institutes">
        <md-card md-whiteframe="4">
            <md-card-title>
                <md-card-title-text>
                    <span class="md-headline">{{institute.shortName}}</span>
                    <span class="md-subhead">{{institute.name}}</span>
                </md-card-title-text>
                <md-card-title-media>
                    <div class="md-media-sm card-media"></div>
                </md-card-title-media>
            </md-card-title>
            <md-card-actions layout="row" layout-align="end center">
                <md-button>Увійти</md-button>
                <md-button>Детальніше</md-button>
            </md-card-actions>
        </md-card>
    </div>
</div>

<script type="text/javascript">
    var app = angular.module('MyApp', ['ngMaterial', 'ngMessages', 'material.svgAssetsCache']);

    app.config(function ($mdThemingProvider) {
        $mdThemingProvider.theme('default')
                .primaryPalette('blue')
                .accentPalette('orange');

        $mdThemingProvider.enableBrowserColor({
            palette: 'accent', // Default is 'primary', any basic material palette and extended palettes are available
            hue: '200' // Default is '800'
        });
    });

    app.controller('ToolbarController', function ($scope, $timeout, $mdSidenav, $mdDialog) {
        var originatorEv;

        $scope.pageTitle = "Інститути";

        $scope.toggleLeft = buildToggler('left');
        $scope.toggleRight = buildToggler('right');

        function buildToggler(componentId) {
            return function () {
                $mdSidenav(componentId).toggle();
            }
        }

        this.openMenu = function ($mdOpenMenu, ev) {
            originatorEv = ev;
            $mdOpenMenu(ev);
        };

        this.announceClick = function (index) {
            $mdDialog.show(
                    $mdDialog.alert()
                            .title('You clicked!')
                            .textContent('You clicked the menu item at index ' + index)
                            .ok('Nice')
                            .targetEvent(originatorEv)
            );
            originatorEv = null;
        };
    });

    app.controller('AppCtrl', function ($compile, $scope) {
    });

    app.controller('CustomCardHolder', function ($compile, $scope) {
    });

    app.controller('InstituteCardController', function ($scope) {
        $scope.institutes = JSON.parse('<%=jsonData%>');
    });

    app.config(function ($mdIconProvider) {
        $mdIconProvider
                .iconSet("call", 'img/icons/sets/communication-icons.svg', 24)
                .iconSet("social", 'img/icons/sets/social-icons.svg', 24);
    });
</script>
</body>
</html>