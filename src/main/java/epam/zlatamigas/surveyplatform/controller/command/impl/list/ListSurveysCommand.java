package epam.zlatamigas.surveyplatform.controller.command.impl.list;

import epam.zlatamigas.surveyplatform.controller.command.Command;
import epam.zlatamigas.surveyplatform.controller.navigation.PageNavigation;
import epam.zlatamigas.surveyplatform.controller.navigation.Router;
import epam.zlatamigas.surveyplatform.controller.navigation.SessionAttributeHolder;
import epam.zlatamigas.surveyplatform.exception.CommandException;
import epam.zlatamigas.surveyplatform.exception.ServiceException;
import epam.zlatamigas.surveyplatform.model.entity.Survey;
import epam.zlatamigas.surveyplatform.service.SurveyService;
import epam.zlatamigas.surveyplatform.service.impl.SurveyServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.util.List;

import static epam.zlatamigas.surveyplatform.controller.navigation.Router.PageChangeType.FORWARD;

public class ListSurveysCommand implements Command {
    @Override
    public Router execute(HttpServletRequest request) throws CommandException {

        SurveyService service = SurveyServiceImpl.getInstance();
        HttpSession session = request.getSession();
        try {

            List<Survey> surveys = service.findParticipantSurveysCommonInfo();
            session.setAttribute(SessionAttributeHolder.SURVEYS, surveys);

        } catch (ServiceException e) {
            throw new CommandException(e.getMessage(), e);
        }

        return new Router(PageNavigation.SURVEYS, FORWARD);
    }
}