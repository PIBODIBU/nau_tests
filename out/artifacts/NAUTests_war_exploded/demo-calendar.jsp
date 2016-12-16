<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Calendar</title>

    <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/angular_material/1.1.0/angular-material.min.css">

    <script src="https://cdn.rawgit.com/bradberger/angular-material-calendar/master/dist/angular-material-calendar.js"></script>
</head>
<body ng-app="BlankApp" ng-cloak>

<form name="myForm" flex-gt-xs>
    <h4>Inside a md-input-container</h4>

    <md-input-container>
        <label>Enter date</label>
        <md-datepicker ng-model="ctrl.myDate" name="dateField" md-min-date="ctrl.minDate"
                       md-max-date="ctrl.maxDate"></md-datepicker>

        <div ng-messages="myForm.dateField.$error">
            <div ng-message="valid">The entered value is not a date!</div>
            <div ng-message="required">This date is required!</div>
            <div ng-message="mindate">Date is too early!</div>
            <div ng-message="maxdate">Date is too late!</div>
        </div>
    </md-input-container>
</form>

<md-card md-theme="{{ showDarkTheme ? 'dark-grey' : 'default' }}" md-theme-watch>
    <md-card-title>
        <md-card-title-text>
            <span class="md-headline">Card with image</span>
            <span class="md-subhead">Large</span>
        </md-card-title-text>
        <md-card-title-media>
            <div class="md-media-lg card-media"></div>
        </md-card-title-media>
    </md-card-title>
    <md-card-actions layout="row" layout-align="end center">
        <md-button>Action 1</md-button>
        <md-button>Action 2</md-button>
    </md-card-actions>
</md-card>

<!-- Angular Material requires Angular.js Libraries -->
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular-animate.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular-aria.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular-messages.min.js"></script>

<!-- Angular Material Library -->
<script src="http://ajax.googleapis.com/ajax/libs/angular_material/1.1.0/angular-material.min.js"></script>

<!-- Your application bootstrap  -->
<script type="text/javascript">
    /**
     * You must include the dependency on 'ngMaterial'
     */
    angular.module('BlankApp', ['ngMaterial']);
</script>

</body>
</html>