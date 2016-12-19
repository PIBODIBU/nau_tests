package ua.edu.nau.hibernate.serializer;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import ua.edu.nau.model.UniversityStructure.Institute;

import java.lang.reflect.Type;

public class InstituteSerializer implements JsonSerializer<Institute> {
    @Override
    public JsonElement serialize(Institute src, Type typeOfSrc, JsonSerializationContext context) {
        JsonObject object = new JsonObject();
        object.addProperty("id", src.getId());
        object.addProperty("name", src.getName());
        object.addProperty("shortName", src.getShortName());
        return object;
    }
}

