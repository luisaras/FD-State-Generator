#include "modified_init_task.h"

using namespace std;

namespace extra_tasks {

ModifiedInitTask::ModifiedInitTask(
    const shared_ptr<AbstractTask> &parent,
    vector<int> &init)
    : DelegatingTask(parent),
      init(init) {
}

std::vector<int> ModifiedInitTask::get_initial_state_values() const {
    return init;
}

}