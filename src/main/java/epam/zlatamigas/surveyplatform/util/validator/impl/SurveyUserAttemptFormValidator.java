package epam.zlatamigas.surveyplatform.util.validator.impl;

import epam.zlatamigas.surveyplatform.controller.navigation.DataHolder;
import epam.zlatamigas.surveyplatform.model.entity.Survey;
import epam.zlatamigas.surveyplatform.model.entity.SurveyQuestion;
import epam.zlatamigas.surveyplatform.model.entity.User;
import epam.zlatamigas.surveyplatform.util.validator.FormValidator;

import java.util.*;

import static epam.zlatamigas.surveyplatform.controller.navigation.DataHolder.*;
import static epam.zlatamigas.surveyplatform.controller.navigation.DataHolder.BUTTONGROUP_NAME_RADIO_ANSWERS;
import static epam.zlatamigas.surveyplatform.util.locale.LocalisedMessageKey.*;

public class SurveyUserAttemptFormValidator implements FormValidator {

    private static FormValidator instance;

    private SurveyUserAttemptFormValidator(){}

    public static FormValidator getInstance() {
        if(instance == null){
            instance = new SurveyUserAttemptFormValidator();
        }
        return instance;
    }

    @Override
    public Map<String, String> validateForm(Map<String, String[]> data) {
        Map<String, String> validationResult = new HashMap<>();

        for(Map.Entry<String, String[]> parameter : data.entrySet()){
            if(parameter.getKey().startsWith(PARAMETER_QUESTION_SELECT_MULTIPLE)){
                String questionId = parameter.getKey().split(PARAMETER_QUESTION_SELECT_MULTIPLE)[1];

                if(Boolean.parseBoolean(parameter.getValue()[0])){
                    // Can select multiple: checkboxes
                    String[] checkboxes = data.get(BUTTONGROUP_NAME_CHECKBOX_ANSWERS + questionId);
                    if (checkboxes == null || checkboxes.length == 0) {
                        validationResult.put(PARAMETER_QUESTION_ID + questionId, MESSAGE_REQUIRE_SELECT_MULTIPLE);
                    }
                } else {
                    // Can select single: radio button
                    String[] radiobuttons = data.get(BUTTONGROUP_NAME_RADIO_ANSWERS + questionId);
                    if(radiobuttons == null || radiobuttons.length != 1){
                        validationResult.put(PARAMETER_QUESTION_ID + questionId, MESSAGE_REQUIRE_SELECT_SINGLE);
                    }
                }
            }
        }

        return validationResult;
    }
}