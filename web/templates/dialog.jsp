<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<md-dialog aria-label="Mango (Fruit)">
    <form ng-cloak>
        <md-toolbar>
            <div class="md-toolbar-tools">
                <h2>{{selectedGroup.name}}</h2>
                <span flex></span>
                <md-button class="md-icon-button" ng-click="cancel()">
                    <md-icon md-svg-src="img/icons/ic_close_24px.svg" aria-label="Close dialog"></md-icon>
                </md-button>
            </div>
        </md-toolbar>

        <md-dialog-content>
            <md-list class="md-no-sticky" layout="row" layout-wrap>
                <div flex-xs="100" flex-gt-xs="50" flex-gt-md="33" flex-xl="25" layout="column"
                     ng-repeat="student in selectedGroup.users">
                    <md-list-item class="md-3-line" ng-click="null">
                        <img ng-src="https://cdn1.iconfinder.com/data/icons/mix-color-4/502/Untitled-1-512.png"
                             class="md-avatar" alt="{{student.name}}"/>
                        <div class="md-list-item-text" layout="column">
                            <h3>{{ student.name }}</h3>
                            <h4>{{ student.email}}</h4>
                            <p>{{ student.username}}</p>
                        </div>
                    </md-list-item>
                </div>
            </md-list>
        </md-dialog-content>

        <md-dialog-actions layout="row">
            <%--<md-button href="http://en.wikipedia.org/wiki/Mango" target="_blank" md-autofocus>
                    More on Wikipedia
                </md-button>
                <span flex></span>
                <md-button ng-click="answer('not useful')">
                    Not Useful
                </md-button>--%>
            <md-button ng-click="answer('useful')">
                Гаразд
            </md-button>
        </md-dialog-actions>
    </form>
</md-dialog>