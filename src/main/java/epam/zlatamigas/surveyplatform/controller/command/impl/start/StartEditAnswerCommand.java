package epam.zlatamigas.surveyplatform.controller.command.impl.start;

import epam.zlatamigas.surveyplatform.controller.command.Command;
import epam.zlatamigas.surveyplatform.controller.navigation.Router;
import epam.zlatamigas.surveyplatform.exception.CommandException;
import jakarta.servlet.http.HttpServletRequest;

public class StartEditAnswerCommand implements Command {
    @Override
    public Router execute(HttpServletRequest request) throws CommandException {
        return null;
    }
}