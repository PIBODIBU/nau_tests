package ua.edu.nau.dao;

import ua.edu.nau.model.Setting;

public interface SettingDAO extends GenericDAO<Setting> {
    Setting getByName(String name);
}
