#ifndef CONTROLLER_H
#define CONTROLLER_H

#include "game.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QObject>
#include <vector>
#include <fstream>


enum playerAction {A, B, C, D, LL5050 = 5050, LL5060 = 5060, LLAUDIENCE = 100, CONCEDE = -1};
static const std::vector<QString> GameColorMap = {"gold", "gold", "red", "lawngreen"};
static const std::vector<int> GamePrizeMap = {  0, 100, 300, 500, 700,
                                                1000, 2000, 3000, 5000, 7000,
                                                10000, 20000, 30000, 60000, 200000,
                                                1000000};
static const std::vector<int> GameResultPrizeMap = {0, 0, 0, 0, 0,
                                                    1000, 1000, 1000, 1000, 1000,
                                                    10000, 10000, 10000, 10000, 10000};


class Controller : public QObject
{
    Q_OBJECT

public:
    Controller(Game                     *game,
               QGuiApplication          *app,
               QQmlApplicationEngine    *engine,
               QObject                  *parent = nullptr);

    void readFileAndCreateQuestions(std::vector<std::vector<Question *>> &QVV,
                                    std::vector<Question *> &QV);
    Q_INVOKABLE inline QString gameStateToColor(){return GameColorMap[game_->state()];}
    Q_INVOKABLE inline int gameRoundToPrize(){return GamePrizeMap[game_->round()];}
    Q_INVOKABLE inline int gameResultToPrize(){return GameResultPrizeMap[game_->round()];}


public slots:
    void initializeGame(QUrl url);
    void startGame();
    void modelStep(int correct);
    void viewStep(int action);
    void quit();


signals:
    void gameInitialized(bool status);
    void gameStarts(bool status);
    void gameEnds(int status, int correct);
    void gameContinues(int correct);
    void gameStateChanged();


private:
    Game *game_;
    QGuiApplication *app_;
    QQmlApplicationEngine *engine_;
    std::string filePath_;
};

#endif // CONTROLLER_H
