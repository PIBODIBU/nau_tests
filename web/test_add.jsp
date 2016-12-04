<%@ page import="ua.edu.nau.helper.constant.Parameter" %>
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
    const PREFIX_ID_INPUT_ANSWERS_CHECKBOX = "answers-checkbox-";
    const PREFIX_ID_QUESTION_TEXT = "question-text-";
    const PREFIX_ID_QUESTION_IMG_URL = "question-img-url-";
    const PREFIX_ID_ANSWERS_LIST = "answers-list-";
    const PREFIX_ID_ANSWERS_RADIO_GROUP = "radio-group-";

    var counter = 1;
    var answersCounter = 1;

    function createGrid(id) {
        var previousGrid;

        previousGrid = document.querySelectorAll(".mdl-grid");
        previousGrid = previousGrid[previousGrid.length - 1];

        var grid = document.createElement("div");

        grid.className = "mdl-grid mdl-shadow--8dp";
        grid.id = id;
        previousGrid.parentNode.insertBefore(grid, previousGrid.nextSibling);

        addHeader(grid);

        return grid;
    }

    function refreshCards() {
        var grid, title, cardCounter = 1;

        for (var i = 0; i <= counter; i++) {
            grid = document.getElementById(PREFIX_ID_GRID + i);

            if (grid != null) {
                title = document.getElementById(PREFIX_ID_TITLE_MAIN_INFO + i);
                title.innerHTML = "Питання №" + cardCounter;

                cardCounter++;
            }
        }
    }

    function createButton(icon, color, onClick) {
        var button = document.createElement("button");
        var buttonIcon = document.createElement("i");

        button.style = "float: right";
        button.className = "mdl-button mdl-js-button mdl-button--icon";

        buttonIcon.className = "material-icons mdl-color-text--" + color;
        buttonIcon.innerHTML = icon;
        button.type = "button";
        button.appendChild(buttonIcon);
        button.addEventListener("click", onClick);

        return button;
    }

    function addHeader(grid) {
        var cellTitle = createCell(PREFIX_ID_CELL + "questions-title-" + counter, 11);
        var cellButtonDelete = createCell(PREFIX_ID_CELL + "button-delete-" + counter, 1);
        var title = createTitle("Питання №" + counter);

        title.style = "margin-top: 16px";
        title.id = PREFIX_ID_TITLE_MAIN_INFO + counter;

        cellButtonDelete.style = "margin: auto";

        cellButtonDelete.appendChild(createButton("delete", "red-500", function () {
            grid.parentNode.removeChild(grid);
            refreshCards();
            counter = counter - 1;
        }));
        cellTitle.appendChild(title);
        grid.appendChild(cellTitle);
        grid.appendChild(cellButtonDelete);
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

    function createInput(type, id, inputName) {
        var input = document.createElement("textarea");
        input.className = "mdl-textfield__input";
        input.setAttribute("name", inputName);
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

    function createList(id) {
        var ul = document.createElement("ul");
        ul.className = "list-icon mdl-list";

        return ul;
    }

    function createAnswer(list, radioButtonId, radioGroupName) {
        var li = document.createElement("li");
        var label = document.createElement("label");
        var radioButton = document.createElement("input");
        var input = createInput("text", "", "<%=Parameter.PARAM_ANSWER_TEXT%>");
        var inputLabel = createInputLabel(input, "Відповідь");
        var inputWrapper = createInputWrapper("");
        var span = document.createElement("span");

        inputWrapper.appendChild(input);
        inputWrapper.appendChild(inputLabel);
        inputWrapper.style = "margin-left: 16px";

        radioButton.type = "radio";
        radioButton.name = radioGroupName;
        radioButton.id = radioButtonId;
        radioButton.className = "mdl-radio__button";

        label.className = "mdl-radio mdl-js-radio mdl-js-ripple-effect";
        label.htmlFor = radioButtonId;

        span.className = "mdl-checkbox__label";

        li.className = "mdl-list__item";

        label.appendChild(radioButton);
        label.appendChild(span);
        li.appendChild(label);
        li.appendChild(inputWrapper);
        list.appendChild(li);

        answersCounter++;

        return li;
    }

    function addNewQuestion() {
        var grid, cell, inputWrapper, input, inputLabel, title,
                answerList;

        // Question main info
        grid = createGrid(PREFIX_ID_GRID + counter);
        cell = createCell(PREFIX_ID_CELL + "main-" + counter, 12);
        inputWrapper = createInputWrapper(PREFIX_ID_INPUT_WRAPPER + counter);
        input = createInput("text", PREFIX_ID_QUESTION_TEXT + counter, "<%=Parameter.PARAM_QUESTION_TEXT%>");
        inputLabel = createInputLabel(input, "Текст питання");

        // Add main info
        grid.appendChild(cell);
        cell.appendChild(inputWrapper);
        inputWrapper.appendChild(input);
        inputWrapper.appendChild(inputLabel);

        // Question main info
        inputWrapper = createInputWrapper();
        input = createInput("url", PREFIX_ID_QUESTION_IMG_URL + counter, "<%=Parameter.PARAM_QUESTION_IMAGE_URL%>");
        inputLabel = createInputLabel(input, "Посилання на фото");

        // Add main info
        cell.appendChild(inputWrapper);
        inputWrapper.append(input);
        inputWrapper.append(inputLabel);

        // Question answers
        title = createTitle("Відповіді");
        title.style = "float: left";
        cell = createCell(PREFIX_ID_CELL + "questions-" + counter, 12);
        answerList = createList(PREFIX_ID_ANSWERS_LIST);
        grid.appendChild(cell);
        cell.appendChild(title);
        var currC = counter;
        cell.appendChild(createButton("add", "blue-500", function () {
            createAnswer(
                    answerList,
                    PREFIX_ID_INPUT_ANSWERS_CHECKBOX + String("is-correct-" + answersCounter),
                    PREFIX_ID_ANSWERS_RADIO_GROUP + currC);
            componentHandler.upgradeDom();
        }));

        // Answers list
        cell = createCell(PREFIX_ID_CELL + "answers-" + counter, 12);
        grid.appendChild(cell);
        cell.appendChild(answerList);

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
            <form action="${pageContext.request.contextPath}/tests/add" method="post">
                <p class="mdl-typography--display-1-color-contrast p-title">Основна інформація</p>

                <div class="mdl-grid mdl-shadow--8dp">
                    <div class="mdl-cell mdl-cell--12-col">
                        <div class="mdl-textfield mdl-js-textfield">
                            <input class="mdl-textfield__input" name="<%=Parameter.PARAM_TEST_NAME%>" type="text"
                                   id="name">
                            <label class="mdl-textfield__label" for="name">Назва</label>
                        </div>
                    </div>

                    <div class="mdl-cell mdl-cell--12-col">
                        <div class="mdl-textfield mdl-js-textfield">
                            <textarea class="mdl-textfield__input" type="text"
                                      name="<%=Parameter.PARAM_TEST_DESCRIPTION%>" rows="2" id="description"></textarea>
                            <label class="mdl-textfield__label" for="description">Опис</label>
                        </div>
                    </div>

                    <div class="mdl-cell mdl-cell--12-col">
                        <div class="mdl-textfield mdl-js-textfield">
                            <input class="mdl-textfield__input" type="number" name="<%=Parameter.PARAM_TEST_TIME%>"
                                   id="time">
                            <label class="mdl-textfield__label" for="time">Час виконання (хв)</label>
                        </div>
                    </div>
                </div>

                <p id="title-questions" class="mdl-typography--display-1-color-contrast p-title">Питання</p>

                <button class="mdl-button mdl-js-button mdl-button--primary"
                        type="submit">
                    Готово
                </button>
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