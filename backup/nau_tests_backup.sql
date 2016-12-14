-- phpMyAdmin SQL Dump
-- version 4.6.4deb1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost:3306
-- Время создания: Дек 14 2016 г., 17:48
-- Версия сервера: 5.6.30-1
-- Версия PHP: 7.0.12-1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `nau_tests`
--

-- --------------------------------------------------------

--
-- Структура таблицы `answers`
--

CREATE TABLE `answers` (
  `id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `is_correct` tinyint(1) NOT NULL,
  `text` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `answers`
--

INSERT INTO `answers` (`id`, `question_id`, `is_correct`, `text`) VALUES
(3, 1, 1, 'Сила і прискорення'),
(4, 1, 0, 'Сила і швидкість'),
(5, 2, 0, 'Відповідь 1 для питання 2'),
(6, 2, 0, 'Відповідь 2 для питання 2'),
(7, 2, 1, 'Відповідь 3 для питання 2'),
(8, 2, 0, 'Відповідь 4 для питання 2'),
(12, 6, 1, 'question-1-answ-1'),
(13, 6, 0, 'question-1-answ-2'),
(14, 6, 0, 'question-1-answ-3'),
(15, 7, 0, 'question-2-answ-1'),
(16, 7, 0, 'question-2-answ-2'),
(17, 7, 0, 'question-2-answ-3'),
(18, 7, 1, 'question-2-answ-4'),
(19, 12, 1, 'Відповідь 1'),
(20, 12, 0, 'Відповідь 2'),
(21, 12, 0, 'Відповідь 3'),
(22, 13, 1, 'читає вектор заданого переривання.'),
(23, 13, 0, 'видаляє вектор заданого переривання.'),
(24, 13, 0, 'змінює вектор заданого переривання.'),
(25, 13, 0, 'оновлює новий вектор переривання по заданій адресі.'),
(26, 14, 0, 'читає вектор заданого переривання.'),
(27, 14, 1, 'установлює новий вектор переривання по заданій адресі.'),
(28, 14, 0, 'копіює видаляє вектор заданого переривання.'),
(29, 14, 0, 'видаляє вектор заданого переривання.'),
(30, 15, 0, 'зберігає позицію точки.'),
(31, 15, 0, 'встановлює позицію точки.'),
(32, 15, 0, 'видаляє позицію точки.'),
(33, 15, 1, 'оновлює позицію точки.'),
(34, 16, 1, 'креслить лінію від поточної позиції до вказаної точки.'),
(35, 16, 0, 'довільно креслить лінію.'),
(36, 16, 0, 'креслить лінію по заданих точках.'),
(37, 16, 0, 'креслить криву по заданих точках.'),
(38, 17, 0, 'креслить довільні точки.'),
(39, 17, 0, ' креслить довільні прямі.'),
(40, 17, 0, 'реслить відрізки з вказаною довжиною.'),
(41, 17, 1, 'креслить відрізки, підключаючи точки у вказаному масиві.'),
(42, 18, 0, 'видаляє точки на  прямих лініях.'),
(43, 18, 1, 'креслить одну або декілька прямих ліній.'),
(44, 18, 0, 'видаляє відрізки.'),
(45, 18, 0, 'креслить точки.'),
(46, 19, 0, 'креслить криву.'),
(47, 19, 0, 'креслить коло.'),
(48, 19, 0, 'креслить прямокутник.'),
(49, 19, 1, 'креслить відрізок прямої та дугу.'),
(50, 20, 1, 'креслить ряд відрізків прямих та кривих Безьє.'),
(51, 20, 0, 'креслить коло.'),
(52, 20, 0, 'креслить дугу.'),
(53, 20, 0, 'креслить відрізок по заданих точках.'),
(54, 21, 1, ' креслить еліптичну дугу.'),
(55, 21, 0, 'креслить пряму.'),
(56, 21, 0, 'креслить ряд відрізків.'),
(57, 21, 0, 'креслить ламану криву.'),
(58, 22, 0, 'видаляє всі креслення.'),
(59, 22, 0, 'копіює всі креслення.'),
(60, 22, 0, 'встановлює напрямок креслення.'),
(61, 22, 1, 'встановлює довжину креслення.'),
(62, 23, 0, '3 км'),
(63, 23, 1, '4 км'),
(64, 23, 0, '5 км'),
(65, 23, 0, '7 км'),
(66, 24, 0, 'vcos 60о'),
(67, 24, 0, 'vctg 60о'),
(68, 24, 1, 'vtg 60о'),
(69, 24, 0, 'vsin 60о'),
(70, 25, 1, '3 кВт'),
(71, 25, 0, '4 кВт'),
(72, 25, 0, '5 кВт'),
(73, 25, 0, '6 кВт'),
(74, 26, 0, '300 г'),
(75, 26, 0, '400 г'),
(76, 26, 0, '500 г'),
(77, 26, 1, '600 г'),
(78, 27, 0, '2'),
(79, 27, 1, '3'),
(80, 27, 0, '4'),
(81, 27, 0, '5'),
(82, 28, 0, '71'),
(83, 28, 0, '72'),
(84, 28, 1, '73'),
(85, 28, 0, '74'),
(86, 29, 0, '6'),
(87, 29, 0, '7'),
(88, 29, 0, '8'),
(89, 29, 1, '9'),
(90, 30, 0, '5 см'),
(91, 30, 0, '6 см'),
(92, 30, 0, '7 см'),
(93, 30, 1, '8 см'),
(94, 31, 1, 'база даних параметрів і настройок операційної системи.'),
(95, 31, 0, 'інтерфейс користувача для вводу-виводу інформації.'),
(96, 31, 0, 'система об’єднаних комп’ютерів.'),
(97, 31, 0, 'енергозалежна частина системи комп’ютерної пам’яті.'),
(98, 32, 0, 'модульна.'),
(99, 32, 0, 'консольна .'),
(100, 32, 1, 'ієрархічна.'),
(101, 32, 0, 'анархічна.'),
(102, 33, 1, 'за допомогою програми regedit.exe.'),
(103, 33, 0, 'за допомогою програми ipconfig.exe.'),
(104, 33, 0, 'за допомогою програми msconfig.exe.'),
(105, 33, 0, 'за допомогою програми isoburn.exe.'),
(106, 34, 1, 'відкриває ключ реєстру.'),
(107, 34, 0, 'закриває ключ реєстру.'),
(108, 34, 0, 'видаляє ключ реєстру'),
(109, 34, 0, 'створює ключ реєстру.'),
(110, 35, 0, 'відкриває ключ реєстру.'),
(111, 35, 0, 'закриває ключ реєстру.'),
(112, 35, 0, 'видаляє ключ реєстру.'),
(113, 35, 1, 'створює ключ реєстру.'),
(114, 36, 0, 'відкриває ключ реєстру.'),
(115, 36, 1, 'закриває ключ реєстру.'),
(116, 36, 0, 'видаляє ключ реєстру.'),
(117, 36, 0, 'створює ключ реєстру.'),
(118, 37, 0, 'відкриває ключ реєстру.'),
(119, 37, 0, 'закриває ключ реєстру.'),
(120, 37, 1, 'видаляє ключ реєстру.'),
(121, 37, 0, 'створює ключ реєстр.'),
(122, 38, 1, 'зберігає ключ реєстру.'),
(123, 38, 0, 'закриває ключ реєстру.'),
(124, 38, 0, 'видаляє ключ реєстру.'),
(125, 38, 0, 'створює ключ реєстру.'),
(126, 39, 1, 'встановлює значення  ключу.'),
(127, 39, 0, 'видаляє значення ключу.'),
(128, 39, 0, 'створює значення ключу.'),
(129, 39, 0, 'зберігає значення ключу.'),
(130, 40, 0, 'змінює розміщення ключу.'),
(131, 40, 0, 'записує дані ключа в реєстр.'),
(132, 40, 1, 'отримує інформацію про ключ. '),
(133, 40, 0, 'перелічує значення ключа.'),
(134, 41, 1, 'інформатика'),
(135, 41, 0, 'фізика'),
(136, 41, 0, 'комп’ютеризація'),
(137, 41, 0, 'математика'),
(138, 42, 0, 'функції інформації'),
(139, 42, 1, ' властивості інформації'),
(140, 42, 0, 'види інформації'),
(141, 42, 0, 'дії інформації'),
(142, 43, 0, 'папка'),
(143, 43, 0, 'файл'),
(144, 43, 0, 'програма'),
(145, 43, 1, 'немає правильної відповіді'),
(146, 44, 1, 'програми-драйвери'),
(147, 44, 0, 'утиліти'),
(148, 44, 0, 'системні програми'),
(149, 44, 0, 'інструментальні програми'),
(150, 45, 0, 'антивірусні'),
(151, 45, 1, 'архіватори'),
(152, 45, 0, 'діагностики'),
(153, 45, 0, 'форматування'),
(154, 46, 1, 'відновлення системи'),
(155, 46, 0, 'очистка диска'),
(156, 46, 0, 'дефрагментація'),
(157, 46, 0, 'перевірка диска');

-- --------------------------------------------------------

--
-- Структура таблицы `http_sessions`
--

CREATE TABLE `http_sessions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `login_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `logout_time` datetime DEFAULT NULL,
  `is_invalid` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `http_sessions`
--

INSERT INTO `http_sessions` (`id`, `user_id`, `login_time`, `logout_time`, `is_invalid`) VALUES
(299, 3, '2016-12-14 16:45:53', NULL, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `text` varchar(1000) NOT NULL,
  `img_url` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `questions`
--

INSERT INTO `questions` (`id`, `test_id`, `text`, `img_url`) VALUES
(1, 1, 'Які з величин (швидкість, сила, прискорення, переміщення) у разі механічного руху завжди збігаються за напрямком?', 'https://sites.google.com/site/fizikacecikavovazlivoprekrasno/_/rsrc/1309172908348/zno/%D0%9D%D0%BE%D0%B2%D1%8B%D0%B9%20%D1%80%D0%B8%D1%81%D1%83%D0%BD%D0%BE%D0%BA%20(58).png'),
(2, 1, 'Питання 2', ''),
(6, 24, 'question-1-text', 'question-1-img'),
(7, 24, 'question-2-text', 'question-2-img'),
(12, 29, 'Що таке Кінематика?', ''),
(13, 30, 'Що виконує функція readvect?', ''),
(14, 30, 'Що виконує функція wrіtevect?', ''),
(15, 30, 'Що виконує функція MoveToEx?', ''),
(16, 30, 'Що виконує функція  LineTo?', ''),
(17, 30, 'Що виконує функція  Polyline?', ''),
(18, 30, 'Що виконує функція PolylineTo?', ''),
(19, 30, 'Що виконує функція AngleArc?', ''),
(20, 30, 'Що виконує функція PolyDraw?', ''),
(21, 30, 'Що виконує функція Arc?', ''),
(22, 30, 'Що виконує функція  SetArcDirection?', ''),
(23, 31, 'Турист пройшов 3 км на захід, потім ще 4 км на північ. Яке переміщення здійснив турист протягом усього маршруту?', ''),
(24, 31, 'Стержень рухається у вертикальній площині, спираючись одним кінцем на підлогу, другим – на стіну. У момент часу, коли стержень розташований під кутом 60о до підлоги, швидкість його нижнього кінця становить v. Яка в цей момент швидкість верхнього кінця стержня?', ''),
(25, 31, 'Легковий автомобіль масою 1,2 т, який рухався прямолінійно зі швидкістю 36 км/год, через 20 с зупиняється під дією сил опору. Чому дорівнює середня потужність сил опору?', ''),
(26, 31, 'Порожній вагон колекційної іграшкової залізниці, який рухається по горизонтальній прямій колії, наздоганяє нерухомий навантажений вагон і зчіплюється з ним у момент часу t0. За графіком залежності імпульсу першого вагона від часу (див. рисунок) визначте масу вантажу в другому вагоні. Маса кожного з порожніх вагонів становить 1 кг.', 'http://192.168.1.230/zno_2017_physics_1.png'),
(27, 31, 'У скільки разів тиск в озері на глибині 30 м більший від тиску на поверхні води? Уважайте, що атмосферний тиск дорівнює 105Па, густина води – 1000 кг/м3, прискорення вільного падіння становить 10 м/с2.', ''),
(28, 31, 'За показами психрометра та даними психрометричної таблиці визначте відносну вологість (%) у кімнаті.', 'http://192.168.1.230/zno_2017_physics_2.png'),
(29, 31, 'Конденсатор складається з двох круглих металевих пластин радіусом 10 см, між якими розташовано пластину текстоліту товщиною 6,28 мм такого самого радіуса. Під час вимірювання електроємності фарадометр показав значення С = 308 пФ (див. рисунок). Визначте діелектричну проникність текстоліту. Уважайте, що електрична стала ε0 дорівнює 8,8 · 10–12 Ф/м.', 'http://192.168.1.230/zno_2017_physics_3.png'),
(30, 31, 'Тягарець масою 500 г здійснює вертикальні коливання на пружині жорсткістю 200 Н/м. Визначте амплітуду коливань, якщо на відстані 4 см відположення рівноваги швидкість тягарця становить 0,6 м/с.', ''),
(31, 32, 'Що таке реєстр?', ''),
(32, 32, 'Яка будова реєстру?', ''),
(33, 32, 'Як викликати редактор реєстру Windows?', ''),
(34, 32, 'Що виконує функція RegOpenKey?', ''),
(35, 32, 'Що виконує функція RegCreateKey?', ''),
(36, 32, 'Що виконує функція RegCloseKey?', ''),
(37, 32, 'Що виконує функція RegDeleteKey?', ''),
(38, 32, 'Що виконує функція RegSaveKey?', ''),
(39, 32, 'Що виконує функція RegSetValue?', ''),
(40, 32, 'Що виконує функція RegQueryInfoKey?', ''),
(41, 33, 'Наука, що вивчає інформацію:', ''),
(42, 33, 'Актуальність, повнота, однозначність, достовірність, зрозумілість - це:', ''),
(43, 33, 'Упорядкована послідовність команд:', ''),
(44, 33, 'Програми, що забезпечують взаємозв’язок з новим обладнанням:', ''),
(45, 33, 'Програми, призначені для створення резервних  копій документів з одночасним їх ущільненням:', ''),
(46, 33, 'Програма, що використовується для відміни змін конфігурації системи і відновлення її параметрів та продуктивності:', ''),
(47, 33, ' Розміщена на носіях велика кількість взаємозв’язаних і структурованих певним чином даних з певної галузі:', '');

-- --------------------------------------------------------

--
-- Структура таблицы `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `value` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `settings`
--

INSERT INTO `settings` (`id`, `name`, `value`) VALUES
(1, 'http_session_time', '60');

-- --------------------------------------------------------

--
-- Структура таблицы `tests`
--

CREATE TABLE `tests` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(300) NOT NULL,
  `owner` int(11) NOT NULL,
  `time` time NOT NULL,
  `color` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `tests`
--

INSERT INTO `tests` (`id`, `name`, `description`, `owner`, `time`, `color`) VALUES
(1, 'Основи динаміки', 'Тест з основ динаміки', 3, '00:20:00', '#03A9F4'),
(24, 'test-name', 'test-descr', 3, '01:00:00', '#E91E63'),
(29, 'Кінематика', 'Опис ', 3, '00:20:00', '#2196F3'),
(30, 'Системне програмування. Модуль 1', 'Модуль №1 з дисципліни "Системне програмування" для студентів 2 курсу спеціальності "Комп\'ютерна інженерія"', 3, '00:20:00', '#3F51B5'),
(31, 'ЗНО 2017. Фізика', 'Тест з фізики для підготовки до ЗНО 2017.', 3, '01:00:00', '#E91E63'),
(32, 'Системне програмування. Модуль 2', 'Модуль №1 з дисципліни "Системне програмування" для студентів 2 курсу спеціальності "Комп\'ютерна інженерія" ', 3, '00:20:00', '#009688'),
(33, 'Тест з інформатики', '', 3, '00:20:00', '#4CAF50'),
(34, 'test 1', 'descr 1', 3, '00:10:00', '#4CAF50');

-- --------------------------------------------------------

--
-- Структура таблицы `test_sessions`
--

CREATE TABLE `test_sessions` (
  `id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `start_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_time` datetime DEFAULT NULL,
  `is_done` tinyint(1) NOT NULL DEFAULT '0',
  `correct_answers` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `university_structure_departments`
--

CREATE TABLE `university_structure_departments` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `short_name` varchar(100) NOT NULL,
  `institute_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `university_structure_departments`
--

INSERT INTO `university_structure_departments` (`id`, `name`, `short_name`, `institute_id`) VALUES
(1, 'НН КСМ', 'КСМ', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `university_structure_groups`
--

CREATE TABLE `university_structure_groups` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `institute_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `university_structure_groups`
--

INSERT INTO `university_structure_groups` (`id`, `name`, `institute_id`, `department_id`) VALUES
(1, 'КС-323', 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `university_structure_institutes`
--

CREATE TABLE `university_structure_institutes` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `short_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `university_structure_institutes`
--

INSERT INTO `university_structure_institutes` (`id`, `name`, `short_name`) VALUES
(1, 'НН ІКІТ', 'ІКІТ');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(300) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `user_role` int(11) DEFAULT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `password`, `email`, `user_role`, `group_id`) VALUES
(3, 'Роман Святненко', 'user', 'pass', 'roman@email.com', 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `users_roles`
--

CREATE TABLE `users_roles` (
  `role_id` int(11) NOT NULL,
  `role_code` int(11) NOT NULL,
  `description` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users_roles`
--

INSERT INTO `users_roles` (`role_id`, `role_code`, `description`) VALUES
(1, 777, 'Root access'),
(2, 644, 'Basic administrator'),
(3, 600, 'Moderator'),
(4, 100, 'Student');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`) USING BTREE;

--
-- Индексы таблицы `http_sessions`
--
ALTER TABLE `http_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `test_id` (`test_id`) USING BTREE;

--
-- Индексы таблицы `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индексы таблицы `tests`
--
ALTER TABLE `tests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`) USING BTREE;

--
-- Индексы таблицы `test_sessions`
--
ALTER TABLE `test_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `test_id` (`test_id`) USING BTREE;

--
-- Индексы таблицы `university_structure_departments`
--
ALTER TABLE `university_structure_departments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `institute_id` (`institute_id`) USING BTREE;

--
-- Индексы таблицы `university_structure_groups`
--
ALTER TABLE `university_structure_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `institute_id` (`institute_id`),
  ADD KEY `department_id` (`department_id`);

--
-- Индексы таблицы `university_structure_institutes`
--
ALTER TABLE `university_structure_institutes`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_role` (`user_role`) USING BTREE,
  ADD KEY `group_id` (`group_id`);

--
-- Индексы таблицы `users_roles`
--
ALTER TABLE `users_roles`
  ADD PRIMARY KEY (`role_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `answers`
--
ALTER TABLE `answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=158;
--
-- AUTO_INCREMENT для таблицы `http_sessions`
--
ALTER TABLE `http_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=300;
--
-- AUTO_INCREMENT для таблицы `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;
--
-- AUTO_INCREMENT для таблицы `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `tests`
--
ALTER TABLE `tests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT для таблицы `test_sessions`
--
ALTER TABLE `test_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;
--
-- AUTO_INCREMENT для таблицы `university_structure_departments`
--
ALTER TABLE `university_structure_departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `university_structure_groups`
--
ALTER TABLE `university_structure_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `university_structure_institutes`
--
ALTER TABLE `university_structure_institutes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT для таблицы `users_roles`
--
ALTER TABLE `users_roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`);

--
-- Ограничения внешнего ключа таблицы `http_sessions`
--
ALTER TABLE `http_sessions`
  ADD CONSTRAINT `http_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`);

--
-- Ограничения внешнего ключа таблицы `tests`
--
ALTER TABLE `tests`
  ADD CONSTRAINT `tests_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `test_sessions`
--
ALTER TABLE `test_sessions`
  ADD CONSTRAINT `test_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `test_sessions_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`);

--
-- Ограничения внешнего ключа таблицы `university_structure_departments`
--
ALTER TABLE `university_structure_departments`
  ADD CONSTRAINT `university_structure_departments_ibfk_1` FOREIGN KEY (`institute_id`) REFERENCES `university_structure_institutes` (`id`);

--
-- Ограничения внешнего ключа таблицы `university_structure_groups`
--
ALTER TABLE `university_structure_groups`
  ADD CONSTRAINT `university_structure_groups_ibfk_1` FOREIGN KEY (`institute_id`) REFERENCES `university_structure_institutes` (`id`),
  ADD CONSTRAINT `university_structure_groups_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `university_structure_departments` (`id`);

--
-- Ограничения внешнего ключа таблицы `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`user_role`) REFERENCES `users_roles` (`role_id`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `university_structure_groups` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
