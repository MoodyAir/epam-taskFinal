package epam.zlatamigas.surveyplatform.controller.command.impl.start;

import epam.zlatamigas.surveyplatform.controller.navigation.Router;
import epam.zlatamigas.surveyplatform.exception.CommandException;
import epam.zlatamigas.surveyplatform.controller.command.Command;
import jakarta.servlet.http.HttpServletRequest;

import static epam.zlatamigas.surveyplatform.controller.navigation.PageNavigation.AUTHORISATION;
import static epam.zlatamigas.surveyplatform.controller.navigation.Router.PageChangeType.FORWARD;


public class StartAuthenticationCommand implements Command {
    @Override
    public Router execute(HttpServletRequest request) throws CommandException {
        return new Router(AUTHORISATION, FORWARD);
    }
}