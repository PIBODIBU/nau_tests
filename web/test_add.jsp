<!DOCTYPE HTML>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Новий тест
    </title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.2.1/material.blue-red.min.css"/>
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:300,400,500,700" type="text/css">
    <script defer src="https://code.getmdl.io/1.2.1/material.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-scrollTo/2.1.0/jquery.scrollTo.min.js"></script>

    <link href="${pageContext.request.contextPath}/css/fab.css" rel="stylesheet">
</head>

<body onload="addNewQuestion()">

<style>
    body {
        width: 100%;
        max-width: 100%;
        background: #f9f9f9;
    }

    .page-content {
        width: 60%;
        margin: 24px auto auto;
        padding-bottom: 24px;
    }

    .mdl-card__actions {
        padding: 0;
    }

    .mdl-textfield {
        width: 100%;
    }

    .mdl-grid {
        margin-top: 24px;
    }

    .mdl-cell {
        padding-right: 24px;
        padding-left: 24px;
    }

    .p-title {
        margin-top: 24px;
    }
</style>

<script type="text/javascript">
    const PREFIX_ID_GRID = "grid-";
    const PREFIX_ID_CELL = "cell-";
    const PREFIX_ID_TITLE_MAIN_INFO = "title-main-info-";
    const PREFIX_ID_INPUT_WRAPPER = "input-wrapper-";
    const PREFIX_ID_QUESTION_TEXT = "question-text-";
    const PREFIX_ID_QUESTION_IMG_URL = "question-img-url-";

    var counter = 1;
    var cardsNumber = 0;

    function createGrid(id) {
        var previousGrid;

        /*if (counter == 1) {
         //            previousGrid = document.getElementById("title-questions");
         previousGrid = document.querySelector(".mdl-grid");
         } else {
         //            previousGrid = document.getElementById(PREFIX_ID_GRID + String(counter));
         previousGrid = grids[grids.length - 1];
         }*/

        previousGrid = document.querySelectorAll(".mdl-grid");
        previousGrid = previousGrid[previousGrid.length - 1];

        var grid = document.createElement("div");

        grid.className = "mdl-grid mdl-shadow--8dp";
        grid.id = id;
        previousGrid.parentNode.insertBefore(grid, previousGrid.nextSibling);

        addDeleteButton(grid);

        return grid;
    }

    function refreshCards() {
        var grid, title, cardCounter = 1;

        for (var i = 0; i <= counter; i++) {
            grid = document.getElementById(PREFIX_ID_GRID + i);

            if (grid != null) {
                title = document.getElementById(PREFIX_ID_TITLE_MAIN_INFO + i);
                title.innerHTML = "Питання №" + cardCounter;

                console.log("Found grid: " + PREFIX_ID_GRID + i + " with title id: " + title.id);

                cardCounter++;
            }
        }
    }

    function addDeleteButton(grid) {
        var cellTitle = createCell(PREFIX_ID_CELL + "questions-title-" + counter, 11);
        var cellButton = createCell(PREFIX_ID_CELL + "button-delete-" + counter, 1);
        var button = document.createElement("button");
        var buttonIcon = document.createElement("i");
        var title = createTitle("Питання №" + counter);

        title.style = "margin-top: 16px";
        title.id = PREFIX_ID_TITLE_MAIN_INFO + counter;

        cellButton.style = "margin: auto";

        button.style = "float: right";
        button.className = "mdl-button mdl-js-button mdl-button--icon";

        buttonIcon.className = "material-icons mdl-color-text--red-500";
        buttonIcon.innerHTML = "delete";
        button.addEventListener("click", function () {
            grid.parentNode.removeChild(grid);
            refreshCards();
            counter = counter - 1;
        });

        button.appendChild(buttonIcon);
        cellButton.appendChild(button);
        cellTitle.appendChild(title);
        grid.appendChild(cellTitle);
        grid.appendChild(cellButton);
    }

    function createCell(id, width) {
        var cell = document.createElement("div");
        cell.id = id;

        cell.className = "mdl-cell mdl-cell--" + width + "-col";

        return cell;
    }

    function createInputWrapper(id) {
        var inputWrapper = document.createElement("div");
        inputWrapper.className = "mdl-textfield mdl-js-textfield";
        inputWrapper.id = id;

        return inputWrapper;
    }

    function createInput(type, id) {
        var input = document.createElement("textarea");
        input.className = "mdl-textfield__input";
        input.setAttribute("type", type);
        input.setAttribute("rows", "2");
        input.id = id;

        return input;
    }

    function createInputLabel(input, text) {
        var inputLabel = document.createElement("label");
        inputLabel.className = "mdl-textfield__label";
        inputLabel.setAttribute("for", input.id);
        inputLabel.innerHTML = text;

        return inputLabel;
    }

    function createTitle(text) {
        var title = document.createElement("p");
        title.className = "mdl-typography--headline";
        title.innerHTML = text;

        return title;
    }

    function addNewQuestion() {
        var grid, cell, inputWrapper, input, inputLabel, title;

        console.log(counter);

        // Question main info
        grid = createGrid(PREFIX_ID_GRID + counter);
        cell = createCell(PREFIX_ID_CELL + "main-" + counter, 12);
        inputWrapper = createInputWrapper(PREFIX_ID_INPUT_WRAPPER + counter);
        input = createInput("text", PREFIX_ID_QUESTION_TEXT + counter);
        inputLabel = createInputLabel(input, "Текст питання");

        // Add main info
        grid.appendChild(cell);
        cell.appendChild(inputWrapper);
        inputWrapper.appendChild(input);
        inputWrapper.appendChild(inputLabel);

        // Question main info
        inputWrapper = createInputWrapper();
        input = createInput("url", PREFIX_ID_QUESTION_IMG_URL + counter);
        inputLabel = createInputLabel(input, "Посилання на фото");

        // Add main info
        cell.appendChild(inputWrapper);
        inputWrapper.append(input);
        inputWrapper.append(inputLabel);

        // Question answers
        title = createTitle("Відповіді");
        cell = createCell(PREFIX_ID_CELL + "questions-" + counter, 12);
        grid.appendChild(cell);
        cell.appendChild(title);

        componentHandler.upgradeDom();
        refreshCards();
        counter++;
    }

    function deleteQuestion(questionGridId) {
        var questionGrid = document.getElementById(questionGridId);
        questionGrid.parentNode.removeChild(questionGrid);
    }

    function addTooltip(parent, text) {

    }
</script>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <span class="mdl-layout-title">Новий тест</span>
            <div class="mdl-layout-spacer"></div>
            <nav class="mdl-navigation mdl-layout--large-screen-only">
            </nav>
        </div>
    </header>

    <div class="mdl-layout__drawer">
        <span class="mdl-layout-title">NAUTests</span>
        <nav class="mdl-navigation">
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/me">Моя сторінка</a>
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/tests">Тести</a>
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/users">Користувачі</a>
            <div class="mdl-card__actions mdl-card--border">
                <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/logout">Вихід</a>
            </div>
        </nav>
    </div>

    <main class="mdl-layout__content">
        <div class="page-content" id="top">
            <form action="#">
                <p class="mdl-typography--display-1-color-contrast p-title">Основна інформація</p>

                <div class="mdl-grid mdl-shadow--8dp">
                    <div class="mdl-cell mdl-cell--12-col">
                        <div class="mdl-textfield mdl-js-textfield">
                            <input class="mdl-textfield__input" type="text" id="name">
                            <label class="mdl-textfield__label" for="name">Назва</label>
                        </div>
                    </div>

                    <div class="mdl-cell mdl-cell--12-col">
                        <div class="mdl-textfield mdl-js-textfield">
                            <textarea class="mdl-textfield__input" type="text" rows="2" id="description"></textarea>
                            <label class="mdl-textfield__label" for="description">Опис</label>
                        </div>
                    </div>

                    <div class="mdl-cell mdl-cell--12-col">
                        <div class="mdl-textfield mdl-js-textfield">
                            <input class="mdl-textfield__input" type="number" id="time">
                            <label class="mdl-textfield__label" for="time">Час виконання (хв)</label>
                        </div>
                    </div>
                </div>

                <p id="title-questions" class="mdl-typography--display-1-color-contrast p-title">Питання</p>
            </form>
        </div>
    </main>

    <button id="fab-add-question"
            class="mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored"
            onclick="addNewQuestion()">
        <i class="material-icons">add</i>
    </button>

    <div class="mdl-tooltip mdl-tooltip--left" data-mdl-for="fab-add-question">
        Додати питання
    </div>
</div>
</body>
</html>