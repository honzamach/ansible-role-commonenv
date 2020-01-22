#!/bin/bash
#----------------------- <+++ansible-managed-file+++> -------------------------+
#
#                             IMPORTANT WARNING
#
#  This file is managed remotely by Ansible orchestration tool. Any local
#  changes will be overwritten without any notice !!! You have been warned !!!
#
#----------------------- <+++ansible-managed-file+++> -------------------------+

COLCODE_BLACK=$(tput setaf 0)
COLCODE_RED=$(tput setaf 1)
COLCODE_GREEN=$(tput setaf 2)
COLCODE_ORANGE=$(tput setaf 3)
COLCODE_BLUE=$(tput setaf 4)
COLCODE_PURPLE=$(tput setaf 5)
COLCODE_CYAN=$(tput setaf 6)
COLCODE_WHITE=$(tput setaf 7)
COLCODE_NC=$(tput sgr0)

COLCODE_B_BLACK=$(tput setab 0)
COLCODE_B_RED=$(tput setab 1)
COLCODE_B_GREEN=$(tput setab 2)
COLCODE_B_ORANGE=$(tput setab 3)
COLCODE_B_BLUE=$(tput setab 4)
COLCODE_B_PURPLE=$(tput setab 5)
COLCODE_B_CYAN=$(tput setab 6)
COLCODE_B_WHITE=$(tput setab 7)

COLCODE_BOLD=$(tput bold)
COLCODE_FAINT=$(tput dim)

MSMS_WIDGET_WIDTH=80
MSMS_SEPARATOR_GLYPH="═"
MSMS_SEPARATOR_PAD=2

#--------------------------------------------------------------------------------------------------


#
# Function "widget_separator_text": center the text with a surrounding border to form a section 
# separator.
#
# Resource and credits for original algorithm: https://unix.stackexchange.com/a/475407
#
# first argument: text to center
# second argument: glyph which forms the border (optional, default: '═')
# third argument: padding width (optional, default: '2')
# fourth argument: colorize output (optional, ['yes', 'no'], default: 'no')
# fifth argument: width of the widget (optional, default: current width of the terminal)
#
function widget_separator_text()
{

    local terminal_width=$(tput cols)                 # query the Terminfo database: number of columns
    local text="${1:?}"                               # text to center
    local border_glyph="${2:-$MSMS_SEPARATOR_GLYPH}"  # glyph to compose the border
    local padding_width="${3:-$MSMS_SEPARATOR_PAD}"   # padding around the text
    local colorized="${4:-no}"                        # use colorized output
    local line_width="${5:-$terminal_width}"          # width of the widget

    local text_width=${#text}
    local border_width=$(( (line_width - (padding_width * 2) - text_width) / 2 ))
    local border=

    # Create the border using given glyph (left side or right side).
    for ((i=0; i<border_width; i++))
    do
        border+="${border_glyph}"
    done

    # A side of the border may be longer depending on the width of the line, text and padding.
    if (( ( line_width - ( padding_width * 2 ) - text_width ) % 2 == 0 ))
    then
        # The left and right borders have the same width.
        local left_border=$border
        local right_border=$left_border
    else
        # The right border has one more character than the left border the text is aligned leftmost.
        local left_border=$border
        local right_border="${border}${border_glyph}"
    fi

    # Space between the text and borders.
    local padding=
    for ((i=0; i<$padding_width; i++))
    do
        padding+=" "
    done

    # Setup color formating.
    local format_start=""
    local format_end=""
    if [[ "$colorized" == 'yes' ]]; then
        format_start="${COLCODE_GREEN}${COLCODE_BOLD}"
        format_end="${COLCODE_NC}"
    fi

    # Displays the text in the center of the screen, surrounded by borders, optionally colorized.
    printf "${format_start}${left_border}${padding}${text}${padding}${right_border}${format_end}\n"
}

#
# Tests:
#
#echo ""
#echo "TESTS: widget_separator_text"
#echo ""
#widget_separator_text "My section separator"
#widget_separator_text "My section separator" "~"
#widget_separator_text "My section separator" "=" 4
#widget_separator_text "My section separator" "~" 4 "yes"
#widget_separator_text "My section separator" "=" 2 "no" 80
#widget_separator_text "My section separator" "~" 2 "yes" 80


#--------------------------------------------------------------------------------------------------


#
# Function "widget_separator": form a section separator.
#
# first argument: glyph which forms the border (optional, default: '═')
# second argument: colorize output (optional, ['yes', 'no'], default: 'no')
# whird argument: width of the widget (optional, default: current width of the terminal)
#
function widget_separator()
{

    local terminal_width=$(tput cols)                 # query the Terminfo database: number of columns
    local border_glyph="${1:-$MSMS_SEPARATOR_GLYPH}"  # glyph to compose the border
    local colorized="${2:-no}"                        # use colorized output
    local line_width="${3:-$terminal_width}"          # width of the widget

    local border=

    # Create the border using given glyph.
    for ((i=0; i<line_width; i++))
    do
        border+="${border_glyph}"
    done

    # Setup color formating.
    local format_start=""
    local format_end=""
    if [[ "$colorized" == 'yes' ]]; then
        format_start="${COLCODE_GREEN}${COLCODE_BOLD}"
        format_end="${COLCODE_NC}"
    fi

    # Displays the text in the center of the screen, surrounded by borders, optionally colorized.
    printf "${format_start}${border}${format_end}\n"
}

#
# Tests:
#
#echo ""
#echo "TESTS: widget_separator"
#echo ""
#widget_separator
#widget_separator "="
#widget_separator "~" "yes"
#widget_separator "#" "yes" 80


#--------------------------------------------------------------------------------------------------


#
# Function "widget_header_box": print given section header text centered within a box.
#
# first argument: text
# second argument: colorize output (optional, ['yes', 'no'], default: 'no')
# third argument: width of the widget (optional, default: current width of the terminal)
#
function widget_header_box() 
{
    local terminal_width=$(tput cols)         # query the Terminfo database: number of columns
    local text="${1:?}"                       # header text to center
    local colorized="${2:-no}"                # use colorized output
    local line_width="${3:-$terminal_width}"  # width of the box

    local text_width=${#text}
    local border_width=$(( line_width - 2 ))
    local padding_width=$(( (line_width - 2 - text_width) / 2 ))

    local border_glyph="═"
    local padding_glyph=" "

    # Top and bottom borders without corners.
    local border=
    for ((i=0; i<$border_width; i++))
    do
        border+="${border_glyph}"
    done

    local border_top="╔${border}╗"
    local border_bottom="╚${border}╝"
    local border_left="║"
    local border_right="║"

    # Create the padding (left side or right side).
    local padding=
    for ((i=0; i<padding_width; i++))
    do
        padding+="${padding_glyph}"
    done

    # A side of the padding may be longer (e.g. the right padding).
    if (( ( line_width - 2 - text_width ) % 2 == 0 ))
    then
        # The left and right paddings have the same width.
        local left_padding=$padding
        local right_padding=$left_padding
    else
        # The right padding has one more character than the left padding the text is aligned leftmost.
        local left_padding=$padding
        local right_padding="${padding}${padding_glyph}"
    fi

    # Setup color formating.
    local format_start=""
    local format_end=""
    if [[ "$colorized" == 'yes' ]]; then
        format_start="${COLCODE_GREEN}${COLCODE_BOLD}"
        format_end="${COLCODE_NC}"
    fi

    # Displays the text in the center of the screen, surrounded by borders, optionally colorized.
    printf "${format_start}${border_top}${format_end}\n"
    printf "${format_start}${border_left}${left_padding}${text}${right_padding}${border_right}${format_end}\n"
    printf "${format_start}${border_bottom}${format_end}\n"
}

#
# Tests:
#
#echo ""
#echo "TESTS: widget_header_box"
#echo ""
#widget_header_box "My section header"
#widget_header_box "My section header" yes
#widget_header_box "My section header" no 80
#widget_header_box "My section header" yes 80

function nrpe_status_clean() { 
    status=${1:-$(</dev/stdin)};
    echo "$status" | sed 's/:/ -/' | cut -f 1 -d \|;
}

function nrpe_status_colorize() {
    local colorized="${1:-no}"                # use colorized output
    local status=${2:-$(</dev/stdin)};

    if [[ "$colorized" == 'yes' ]]; then
        if [[ $status =~ " OK " ]]; then
           echo "$status" | sed "s/ OK / ${COLCODE_GREEN}${COLCODE_BOLD}OK${COLCODE_NC} /"
        elif [[ ${status:0:2} = "OK" ]]; then
           echo "$status" | sed "s/OK /${COLCODE_GREEN}${COLCODE_BOLD}OK${COLCODE_NC} /"
        elif [[ $status =~ " WARNING " ]]; then
            echo "$status" | sed "s/ WARNING / ${COLCODE_B_ORANGE}${COLCODE_WHITE}${COLCODE_BOLD}WARNING${COLCODE_NC} /"
        elif [[ $status =~ " CRITICAL " ]]; then
            echo "$status" | sed "s/ CRITICAL / ${COLCODE_B_RED}${COLCODE_WHITE}${COLCODE_BOLD}CRITICAL${COLCODE_NC} /"
        else
            echo "$status"
        fi
    else
        echo "$status"
    fi
}

#
# Tests:
#
#echo ""
#echo "TESTS: nrpe_status_colorize"
#echo ""
#echo "TEST OK - Something" | sed "s/ OK / ${COLCODE_GREEN}${COLCODE_BOLD}OK${COLCODE_NC} /"
#echo "TEST OK - Something OK OK" | nrpe_status_colorize "yes"
#echo "TEST OK - Something OK OK" | nrpe_status_colorize "no"
#echo "OK - Something OKOK" | nrpe_status_colorize "yes"
#echo "TEST WARNING: Something WARNING WARNING | something else" | nrpe_status_clean | nrpe_status_colorize "yes"
#echo "TEST CRITICAL - Something CRITICAL CRITICAL" | nrpe_status_colorize "yes"
#echo "TEST CRITICAL - Something CRITICAL CRITICAL" | nrpe_status_colorize "no"
