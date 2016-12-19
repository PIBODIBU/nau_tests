<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Groups</title>

    <jsp:include page="angular_commons.jsp"/>
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
        <div layout-padding>
            <span class="md-title">Svyatnenko Roman</span>
            <small class="md-caption">roman@gmail.com</small>
        </div>
    </md-toolbar>

    <md-content layout-margin>
        <p>
            This sidenav is not showing any backdrop, where users can click on it, to close the sidenav.
        </p>
    </md-content>
</md-sidenav>

<div layout="row" flex layout-wrap ng-controller="GroupsCardController  as controller"
     class='md-padding'>
    <md-content flex-gt-md="33" flex-xs="100" flex-gt-xs="50" flex-xl="25" layout="column"
                ng-repeat="group in groups | orderBy:'name'">
        <md-card flex md-whiteframe="4">
            <md-card-title>
                <md-card-title-text>
                    <span class="md-headline">{{group.id}}</span>
                    <span class="md-subhead">{{group.name}}</span>
                </md-card-title-text>
                <md-card-title-media>
                    <div class="md-media-sm card-media"></div>
                </md-card-title-media>
            </md-card-title>
            <md-card-actions layout="row" layout-align="end center">
                <md-button ng-click="showAdvanced($event, group.id)">Студенти</md-button>
                <md-button>Детальніше</md-button>
            </md-card-actions>
        </md-card>
    </md-content>
</div>

<script type="text/javascript">
    var app = angular.module('MyApp',
            ['ngMaterial', 'ngMessages', 'material.svgAssetsCache']);

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

        $scope.pageTitle = "Групи";

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

    function DialogController($scope, $mdDialog) {
        $scope.hide = function () {
            $mdDialog.hide();
        };

        $scope.cancel = function () {
            $mdDialog.cancel();
        };

        $scope.answer = function (answer) {
            $mdDialog.hide(answer);
        };
    }

    app.controller('GroupsCardController', function ($scope, $mdDialog) {
        $scope.groups = JSON.parse('${jsonData}');

        $scope.getGroupById = function (groups, groupId) {
            for (var i = 0; i < groups.length; i++) {
                if (groups[i].id == groupId) {
                    return groups[i];
                }
            }
        };

        $scope.showAdvanced = function (ev, groupId) {
            $scope.selectedGroup = $scope.getGroupById($scope.groups, groupId);

            $mdDialog.show({
                controller: DialogController,
                scope: $scope.$new(),
                templateUrl: '/templates/dialog.jsp',
                parent: angular.element(document.body),
                targetEvent: ev,
                clickOutsideToClose: true,
            })
                    .then(function (answer) {
                        $scope.status = 'You said the information was "' + answer + '".';
                    }, function () {
                        $scope.status = 'You cancelled the dialog.';
                    });
        };
    });

    app.config(function ($mdIconProvider) {
        $mdIconProvider
                .iconSet("call", 'img/icons/sets/communication-icons.svg', 24)
                .iconSet("social", 'img/icons/sets/social-icons.svg', 24);
    });
</script>
</body>
</html>