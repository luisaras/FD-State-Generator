import pddl_parser


def read_initial_state(file_name):
    new_sas = open(file_name, "r")
    
    variables = []
    state_str = ""
    
    line = new_sas.readline()
    while line:
        if "begin_variable" in line:
            variable = []
            new_sas.readline() # name
            new_sas.readline() # axiom layer
            for i in range(int(new_sas.readline())): # domain size
                variable.append(new_sas.readline()) # value
            if not "end_variable" in new_sas.readline()
                sys.exit("Expected end_variable.")
            variables.append(variable)
            continue
        if "begin_state" in line:
            line = new_sas.readline()
            while "end_state" not in line:
                state_str += " " + line
                line = new_sas.readline()
            continue
        line = new_sas.readline()
    new_sas.close()
    
    state_values = [int(x) for x in state_str.strip().split()]
    for var in range(len(state_values)):
        val = state_values[var]
        state_values[var] = variables[var][val]
    return state_values


def find_pddl_init(pddl):
    if (type(pddl[0]) is str) and pddl[0].lower() == ":init":
        return pddl
    for i in range(len(pddl)):
        if type(pddl[i]) is str:
            continue
        pddl_init = find_pddl_init(pddl[i])
        if pddl_init:
            return pddl_init


def pddl_var_to_string(pddl):
    if type(pddl) is str:
        return pddl
    if len(pddl) == 1:
        return pddl_var_to_string(pddl[0]) + "()"
    name = pddl_var_to_string(pddl[0]) + "(" + pddl_var_to_string(pddl[1])
    for i in range(2, len(pddl)):
        name += "," + pddl_var_to_string(pddl[i])
    return name + ")"


def replace_init_values(state_values, pddl):
    if not pddl:
        sys.exit(":init not found in PDDL.")
    n_lines = len(pddl)
    for i in range(1, n_lines):
        if type(pddl[i]) is str:
            for value in state_values:
                if pddl[i] in value:
                    if "NegatedAtom" in value:
                        pddl[i] = ["not", pddl[i]]
                        break
            continue
        negated = False
        list = pddl[i]
        if type(list[0]) is str and list[0].lower() == "not":
            negated = True
            list = list[1]
        name = pddl_var_to_string(list)
        for value in state_values:
            if name in value:
                if negated:
                    if "NegatedAtom" not in value:
                        pddl[i] = list
                        break
                else:
                    if "NegatedAtom" in value:
                        pddl[i] = ["not", pddl[i]]
                        break

def write_pddl(file, pddl):
    print(pddl)

def main():
    state_values = read_initial_state(sys.argv[2])
    pddl = pddl_parser.parse_pddl_file("task", sys.argv[1])
    replace_init_values(state_values, find_pddl_init(pddl))
    with open(sys.argv[3], "w") as new_pddl_file:
        write_pddl(new_pddl_file, pddl)
    print("New PDDL file successfully written.")

if __name__ == "__main__":
    main()

