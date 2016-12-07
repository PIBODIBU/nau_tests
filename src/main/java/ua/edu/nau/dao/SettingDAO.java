package ua.edu.nau.dao;

import ua.edu.nau.model.Setting;

public interface SettingDAO extends BasicDAO<Setting> {
    Setting getByName(String name);
}
