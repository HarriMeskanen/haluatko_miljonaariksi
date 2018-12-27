#include "question.h"

Question::Question(std::vector<std::string> &v)
    : locked(false)
{
    if ( !(std::istringstream(v.front()) >> level_) )
        throw -1;

    if ( !(std::istringstream(v.back()) >> correct_) )
        throw -1;

    if( ((level_ | correct_) > 3))
        throw -1;

    question_ = QString::fromStdString(v.at(1));
    choice_[0] = QString::fromStdString(v.at(2));
    choice_[1] = QString::fromStdString(v.at(3));
    choice_[2] = QString::fromStdString(v.at(4));
    choice_[3] = QString::fromStdString(v.at(5));
}
