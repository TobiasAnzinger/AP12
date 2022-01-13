package jpa;


import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

//to use:
//    @Convert(converter = NameConverter.class)


@Converter
public class NameConverter implements AttributeConverter<String, String> {


    @Override
    public String convertToDatabaseColumn(String attribute) {
        return attribute.length() >= 30 ? attribute.substring(0, 30) : attribute;
    }

    @Override
    public String convertToEntityAttribute(String dbData) {
        return dbData;
    }
}
