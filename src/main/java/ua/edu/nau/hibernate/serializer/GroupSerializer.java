package ua.edu.nau.hibernate.serializer;

import com.google.gson.*;
import ua.edu.nau.model.UniversityStructure.Group;
import ua.edu.nau.model.User;

import java.lang.reflect.Type;

public class GroupSerializer implements JsonSerializer<Group> {
    @Override
    public JsonElement serialize(Group src, Type typeOfSrc, JsonSerializationContext context) {
        JsonObject object = new JsonObject();
        JsonArray users = new JsonArray();
        UserSerializer userSerializer = new UserSerializer();

        for (User user : src.getUsers()) {
            users.add(userSerializer.serialize(user, typeOfSrc, context));
        }

        object.addProperty("id", src.getId());
        object.addProperty("name", src.getName());
        object.add("users", users);

        return object;
    }
}
