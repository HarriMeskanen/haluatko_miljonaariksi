#include "controller.h"

Controller::Controller(Game *game, QGuiApplication *app, QQmlApplicationEngine *engine, QObject* parent)
    : QObject(parent), game_(game), app_(app), engine_(engine), filePath_("")
{
    engine_->rootContext()->setContextProperty("controller", this);
    engine_->rootContext()->setContextProperty("model", game_);
    connect(game_, &Game::stateChanged, this, &Controller::gameStateChanged);
    connect(game_, &Game::stepSignal, this, &Controller::modelStep);
}


void Controller::initializeGame(QUrl url)
{
    std::string path = url.path().toStdString();
    //  "/C:/..." --> "C:/..."
    path = path.substr(1, path.length());

    if(path == filePath_)
        return;

    filePath_ = path;
    std::vector<Question*> *QV;

    QV = readFileAndCreateQuestions();

    if(!game_->initialize(QV))
        emit errorSignal(static_cast<int>(INITIALIZATION_ERROR));
}


void Controller::startGame()
{
    switch(game_->state())
    {
    case UNINITIALIZED:
        emit errorSignal(static_cast<int>(UNINITIALIZED_START_ERROR));
        break;

    case LOCKED:
        emit errorSignal(static_cast<int>(LOCKED_START_ERROR));
        break;

    case INITIALIZED:
    case OFF:
        emit gameStarts();
        game_->start();
        break;

    // added to avoid dumb editor warning
    case ON:
        break;
    }
}


void Controller::modelStep(int correct)
{
    switch(game_->state())
    {
    case OFF:
    case LOCKED:
        emit gameEnds(game_->winStatus(), correct);
        break;
    case ON:
        emit gameContinues(correct);
        break;
    // added to avoid dumb editor warning
    case UNINITIALIZED:
    case INITIALIZED:
        break;
    }
}


void Controller::viewStep(int action)
{
    switch (action)
    {
    case A:
    case B:
    case C:
    case D:
        game_->step(action);
        break;

    case LL5050:
        game_->LL5050();
        break;

    case LL5060:
        game_->LL5060();
        break;

    case LLAUDIENCE:
        game_->LLAUDIENCE();
        break;

    case CONCEDE:
        game_->stop();
        emit gameEnds(-1, game_->correct());
        break;
    }
}


std::vector<Question*>* Controller::readFileAndCreateQuestions()
{
    std::ifstream file(filePath_);
    std::string line;

    Question* q = nullptr;
    auto *QV = new std::vector<Question*>();

    if(file.is_open())
    {
        // read lines
        while(std::getline(file, line))
        {
            std::vector<std::string> v;
            size_t ii = 0;
            size_t jj = 0;

            // parse line
            while (jj != line.npos)
            {
                jj = line.find(';', ii);
                v.push_back(line.substr(ii, jj-ii));
                ii = jj + 1;
            }

            if(v.size() != 7)
                continue;

            try
            {
                q = new Question(v);
                q->index = QV->size();
            }
            catch (int)
            {
                delete q;
                q = nullptr;
                continue;
            }
            QV->push_back(q);
        }
        file.close();
    }
    return QV;
}

void Controller::reverseGame()
{
    if(game_->state() == UNINITIALIZED)
        return;

    game_->reverse();
}

void Controller::quit()
{
    game_->quit();
    engine_->quit();
    app_->quit();
}
