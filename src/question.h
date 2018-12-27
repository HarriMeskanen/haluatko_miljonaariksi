#ifndef QUESTION_H
#define QUESTION_H


#include <vector>
#include <QString>
#include <sstream>

class Question
{

public:
    Question(std::vector<std::string> &v);
    inline int level(){return level_;}
    inline QString question(){return question_;}
    inline QString a(){return choice_[0];}
    inline QString b(){return choice_[1];}
    inline QString c(){return choice_[2];}
    inline QString d(){return choice_[3];}
    inline int correct(){return correct_;}
    inline void setChoice(size_t ii, QString val){choice_[ii] = val;}
    bool locked;
    size_t index;


private:
    int level_;
    QString question_;
    QString choice_[4];
    int correct_;

};

#endif // QUESTION_H
