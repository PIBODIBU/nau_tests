package ua.edu.nau.helper;

import ua.edu.nau.dao.SettingDAO;
import ua.edu.nau.dao.impl.SettingDAOImpl;
import ua.edu.nau.model.HttpSession;
import ua.edu.nau.model.Setting;

import java.util.Date;

public class SessionHelper {
    public static Boolean isSessionTimedOut(HttpSession httpSession) {
        SettingDAO settingDAO = new SettingDAOImpl();
        Setting setting = settingDAO.getByName(SettingDAOImpl.SETTING_SESSION_TIME);

        Date loginTime = httpSession.getLoginTime();
        Date invalidationTime = new Date((loginTime.getTime() + TimeFormatter.minutesToMillisLong(setting.getValue())));
        Date currentTime = new Date();

        System.out.println("Login time: " + loginTime.toString());
        System.out.println("Current time: " + currentTime.toString());
        System.out.println("Invalidation time: " + invalidationTime.toString());

        return invalidationTime.getTime() > currentTime.getTime();
    }
}