#!/bin/bash

# PREREQUISITES
echo "PREREQUISITES: Docker"
echo ""

# BUILD DOCKER IMAGE
function build_docker_image() {
    print_title "BUILD DOCKER IMAGE"
    docker build -t tesstrainer .
}

# CREATE NEW CONTAINER
function create_new_container() {
    print_title "CREATE NEW CONTAINER"
    printf 'This will override the existing container.\nDo you want to continue? (Y/n)? '
    read answer
    if [ "$answer" != "${answer#[Nn]}" ] ;then
        return
    fi

    docker rm -f tesstrainer_run
    docker run -d -p 4022:22 \
        --volume="$(pwd)"/workspace:/tesstrainer/workspace \
        --volume="$(pwd)"/scripts:/tesstrainer/scripts \
        --hostname=tesstrainer \
        --name tesstrainer_run tesstrainer
}

# BUILD SOURCES
function build_sources() {
    print_title "BUILD SOURCES"
    echo "Compiling leptonica..."
    docker exec -it tesstrainer_run sh scripts/compile_leptonica.sh
    echo "Compiling tesseract..."
    docker exec -it tesstrainer_run sh scripts/compile_tesseract.sh
    docker exec -it tesstrainer_run tesseract \-v
}

# GENERATE TRAIN & EVAL DATA
function generate_train_and_eval_data() {
    print_title "GENERATE TRAIN & EVAL DATA"
    echo "The training text should be placed in 'workspace/sin.trainingtext' file."
    read -p "Press enter to continue."

    echo "Generate training data..."
    docker exec -it tesstrainer_run sh scripts/generate_trainingdata.sh
    echo "Generate evaluation data..."
    docker exec -it tesstrainer_run sh scripts/generate_evaldata.sh
}

# START TRAINING
function start_training() {
    docker exec tesstrainer_run sh scripts/start_training.sh
}

# OPEN CONTAINER
function open_container() {
    docker exec -it tesstrainer_run /bin/bash
}

# PRINT TITLE
function print_title() {
    HLINE==============================================
    printf "\n$HLINE\n $1\n$HLINE\n"
}

# EXECUTE OPERATIONS
while true; do
    print_title "SELECT AN OPERATION..."
    echo "  1) Build the docker image"
    echo "  2) Create a new container"
    echo "  3) Build letptonica & tesseract sources"
    echo "  4) Generate train & eval data"
    echo "  5) Start training"
    echo "  6) Open container"
    echo "  q) Quit"

    read n
    case $n in
    1) build_docker_image;;
    2) create_new_container;;
    3) build_sources;;
    4) generate_train_and_eval_data;;
    5) start_training;;
    6) open_container;;
    q) exit ;;
    *) echo "invalid option";;
    esac
done

