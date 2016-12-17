package ua.edu.nau.helper.hibernate;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import ua.edu.nau.model.UniversityStructure.Group;

import java.lang.reflect.Type;

public class GroupSerializer implements JsonSerializer<Group> {
    @Override
    public JsonElement serialize(Group src, Type typeOfSrc, JsonSerializationContext context) {
        JsonObject object = new JsonObject();
        object.addProperty("id", src.getId());
        object.addProperty("name", src.getName());
        return object;
    }
}
