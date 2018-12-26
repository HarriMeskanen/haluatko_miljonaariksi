#include "game.h"


Game::Game(QObject *parent)
    : QObject(parent), current_(nullptr), round_(0), MAX_ROUNDS_(14),
      state_(UNINITIALIZED), winStatus_(false)
{
    for(size_t i=0; i < 4; i++)
        QVV_.push_back(std::vector<Question*>());

    srand(static_cast<unsigned int>(time(nullptr)));
}


Game::~Game()
{
    for(size_t i=0; i<QV_.size(); i++)
        delete QV_.at(i);
}

void Game::setState(enum state s)
{
    state_ = s;
    emit stateChanged();
}

bool Game::start()
{
    switch(state_)
    {
    case UNINITIALIZED:
        return false;

    case OFF:
        reverse();
        [[clang::fallthrough]];

    case INITIALIZED:
        setState(ON);
        setQuestion();
        break;

    // added to avoid dumb editor warning.
    case ON:
        break;
    }    
    return true;
}


bool Game::initialize(std::vector<std::vector<Question*>> QVV,
                      std::vector<Question*> QV)
{
    auto sz0 = QVV.at(0).size();
    auto sz1 = QVV.at(1).size();
    auto sz2 = QVV.at(2).size();
    auto sz3 = QVV.at(3).size();

    if( ((sz0 | sz1) < 5) | (sz2 < 4) | !sz3 )
    {
        return false;
    }

    reset();

    QVV_ = QVV;
    QV_ = QV;

    setState(INITIALIZED);

    return true;
}

void Game::step(int guess)
{

    if(!isCorrect(guess))
        setState(OFF);

    else if(round_ == MAX_ROUNDS_)
    {
        winStatus_ = true;
        setState(OFF);
    }
    else
    {
        round_ += 1;
        setQuestion();
    }
    emit stepSignal(current_->correct());
}

void Game::LL5050()
{
    int ii, jj, kk;
    kk = current_->correct();

    do {
        ii = rand() % 4;
    } while (ii == kk);
    do {
        jj = rand() % 4;
    } while(( (jj == ii) | (jj == kk) ));

    current_->setChoice(static_cast<size_t>(ii),"");
    current_->setChoice(static_cast<size_t>(jj),"");
    emit modelChanged();
}

void Game::LL5060()
{
    int ii, kk;
    kk = current_->correct();

    do {
       ii = rand() % 4;
    } while (ii == kk);

    current_->setChoice(static_cast<size_t>(ii),"");
    emit modelChanged();
}

void Game::LLAUDIENCE()
{
    int votes[4] = {0, 0, 0, 0};
    int i, j, k, iter;
    int C = current_->correct();
    int N = 100;

    switch(current_->level())
    {
    case 0:
        for(i=0;i<4;i++)
        {
            if(i == C)
                continue;

            for(iter=0; iter<N/2; iter++)
            {
                if(rand() % 2)
                    votes[i] += 1;
                else votes[C] += 1;
            }
        }
        votes[rand() % 4] += 20;
        break;

    case 1:
        for(i=0; i<3; i++)
        {
            if(i == C)
                continue;

            for(j=i+1; j<4; j++)
            {
                if (j == C)
                    continue;

                for(iter=0;iter<N/4;iter++)
                {
                    k = rand() % 3;
                    if(k == 0)
                        votes[C] += 1;

                    else if(k==1)
                        votes[i] += 1;

                    else votes[j] += 1;
                }
            }
        }
        votes[rand() % 4] += 12;
        break;

    case 2:
    case 3:
        for(iter=0;iter<N;iter++)
        {
            votes[rand() % 4] += 1;
        }
        break;
    }
    emit voteResults(votes[0], votes[1], votes[2], votes[3]);
}


void Game::setQuestion()
{
    size_t level, prevLevel;

    if(round_ == 0)
        prevLevel = 0;
    else prevLevel = static_cast<size_t>(current_->level());

    if(round_ < 5)
        level = 0;
    else if(round_ < 10)
        level = 1;
    else if(round_ < 14)
        level = 2;
    else
        level = 3;

    if(level != prevLevel)
        emit levelChanged(static_cast<int>(level));

    std::vector<Question*> *v = &QVV_.at(level);
    Question *q;
    int nv = static_cast<int>(v->size());
    int ii;

    do
    {
        ii = rand() % nv;
        q = v->at(static_cast<size_t>(ii));
    }while(q->locked);

    q->locked = true;
    AQV_.push_back(q->index);
    current_ = q;

    emit modelChanged();
}


bool Game::isCorrect(int guess)
{
    if(current_->correct() == guess)
        return true;

    else return false;
}


void Game::reset()
{
    for(size_t i=0; i<4; i++)
        QVV_.at(i).clear();
    QV_.clear();
    AQV_.clear();
    current_ = nullptr;
    round_ = 0;
    winStatus_ = false;
    setState(UNINITIALIZED);
}


void Game::reverse()
{
    for (size_t i=0; i<AQV_.size(); i++)
        QV_.at(AQV_.at(i))->locked = false;

    AQV_.clear();
    current_ = nullptr;
    round_ = 0;
    winStatus_ = false;
    setState(INITIALIZED);
}

void Game::quit()
{
    reset();
}
