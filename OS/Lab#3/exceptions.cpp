#include <bits/exception.h>
#include <string>
#include <utility>

class ConstructorException: std::exception {
    std::string problem;

public:
    explicit ConstructorException(std::string problem) {
        this->problem = std::move(problem);
    }

    const char * what() const noexcept override {
        return problem.c_str();
    }
};

class CreateFileException: std::exception {
    std::string problem;

public:
    explicit CreateFileException(std::string problem) {
        this->problem = std::move(problem);
    }

    const char * what() const noexcept override {
        return problem.c_str();
    }
};

class FullDiskException: std::exception {
    std::string problem;

public:
    explicit FullDiskException(std::string problem) {
        this->problem = std::move(problem);
    }

    const char * what() const noexcept override {
        return problem.c_str();
    }
};

class FullClusterException: std::exception {
    std::string problem;

public:
    explicit FullClusterException(std::string problem) {
        this->problem = std::move(problem);
    }

    const char * what() const noexcept override {
        return problem.c_str();
    }
};

class DirNotFoundException: std::exception {
    std::string problem;

public:
    explicit DirNotFoundException(std::string problem) {
        this->problem = std::move(problem);
    }

    const char * what() const noexcept override {
        return problem.c_str();
    }
};
