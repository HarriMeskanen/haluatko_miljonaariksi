#ifndef GAME_H
#define GAME_H

#include "question.h"

#include <QObject>
#include <QUrl>
#include <vector>
#include <cstdlib>
#include <ctime>


enum state {OFF, ON, UNINITIALIZED, INITIALIZED, LOCKED};


class Game : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString question READ question)
    Q_PROPERTY(QString a READ a)
    Q_PROPERTY(QString b READ b)
    Q_PROPERTY(QString c READ c)
    Q_PROPERTY(QString d READ d)
    Q_PROPERTY(unsigned int round READ round)


public:
    Game(QObject *parent = nullptr);    
    ~Game();

    bool initialize(std::vector<Question*> *QV);
    void start();
    void stop();
    void setQuestion();
    bool isCorrect(int guess);
    int correct();
    inline bool winStatus(){return winStatus_;}
    void reset();
    void reverse();
    inline state state(){return state_;}
    void setState(enum state s);
    void quit();

    void step(int guess);
    void LL5050();
    void LL5060();
    void LLAUDIENCE();

    inline QString question(){return current_->question();}
    inline QString a(){return current_->a();}
    inline QString b(){return current_->b();}
    inline QString c(){return current_->c();}
    inline QString d(){return current_->d();}
    inline unsigned int round(){return round_;}


signals:
    void stateChanged();
    void modelChanged();
    void levelChanged(int level);
    void stepSignal(int correct);
    void voteResults(int a, int b, int c, int d);


private:
    // Question-Vector
    std::vector<Question*> *QV_;
    // Question-Vector-Vector
    // 4 containers for easy, normal, hard and pro level questions
    // rounds   1   to  5   : easy
    //          6   to  10  : normal
    //          11  to  14  : hard
    //          15  to  Inf : pro
    std::vector<std::vector<Question*>> QVV_;
    // asked questions vector. indeces of QV_
    std::vector<size_t> AQV_;
    // current question
    Question* current_;
    // round number
    unsigned int round_;
    // number of rounds in game. def 15
    const unsigned int MAX_ROUNDS_;
    enum state state_;
    bool winStatus_;

};

#endif // GAME_H
