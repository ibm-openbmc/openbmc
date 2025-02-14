#!/bin/bash

# Define the GPIO name mapping
declare -A gpio_name_mapping=(
    [0]="Reserved (SGPIO 0)"
    [1]="Reserved (SGPIO 1)"
    [2]="Reserved (SGPIO 2)"
    [3]="SW256_PWROK (SGPIO 3)"
    [4]="STORAGE_BP_PRSNT_N_FF (SGPIO 4)"
    [5]="RST_PLTRST_N_FF (SGPIO 5)"
    [6]="RST_RSMRST_N_REQ (SGPIO 6)"
    [7]="CLKGEN_CKPWRGD (SGPIO 7)"
    [8]="wFAULT_SOURCE[0] (SGPIO 8)"
    [9]="wFAULT_SOURCE[1] (SGPIO 9)"
    [10]="wFAULT_SOURCE[2] (SGPIO 10)"
    [11]="wFAULT_SOURCE[3] (SGPIO 11)"
    [12]="PSU4_PRESENT_N (SGPIO 12)"
    [13]="PSU3_PRESENT_N (SGPIO 13)"
    [14]="PSU2_PRESENT_N (SGPIO 14)"
    [15]="PSU1_PRESENT_N (SGPIO 15)"
    [16]="sgpio_byte_RAIL_ALERT_LIVE_STATUS_ENCODED[0] (SGPIO 16)"
    [17]="sgpio_byte_RAIL_ALERT_LIVE_STATUS_ENCODED[1] (SGPIO 17)"
    [18]="sgpio_byte_RAIL_ALERT_LIVE_STATUS_ENCODED[2] (SGPIO 18)"
    [19]="sgpio_byte_RAIL_ALERT_LIVE_STATUS_ENCODED[3] (SGPIO 19)"
    [20]="sgpio_byte_RAIL_ALERT_LIVE_STATUS_ENCODED[4] (SGPIO 20)"
    [21]="sgpio_byte_RAIL_ALERT_LIVE_STATUS_ENCODED[5] (SGPIO 21)"
    [22]="sgpio_byte_RAIL_ALERT_LIVE_STATUS_ENCODED[6] (SGPIO 22)"
    [23]="sgpio_byte_RAIL_ALERT_LIVE_STATUS_ENCODED[7] (SGPIO 23)"
    [24]="sgpio_latch_byte_RAIL_ALERT_FAIL_STATUS_ENCODED[0] (SGPIO 24)"
    [25]="sgpio_latch_byte_RAIL_ALERT_FAIL_STATUS_ENCODED[1] (SGPIO 25)"
    [26]="sgpio_latch_byte_RAIL_ALERT_FAIL_STATUS_ENCODED[2] (SGPIO 26)"
    [27]="sgpio_latch_byte_RAIL_ALERT_FAIL_STATUS_ENCODED[3] (SGPIO 27)"
    [28]="sgpio_latch_byte_RAIL_ALERT_FAIL_STATUS_ENCODED[4] (SGPIO 28)"
    [29]="sgpio_latch_byte_RAIL_ALERT_FAIL_STATUS_ENCODED[5] (SGPIO 29)"
    [30]="sgpio_latch_byte_RAIL_ALERT_FAIL_STATUS_ENCODED[6] (SGPIO 30)"
    [31]="sgpio_latch_byte_RAIL_ALERT_FAIL_STATUS_ENCODED[7] (SGPIO 31)"
    [32]="Reserved (SGPIO 32)"
    [33]="Reserved (SGPIO 33)"
    [34]="current_step_enables[5] (SGPIO 34)"
    [35]="current_step_enables[4] (SGPIO 35)"
    [36]="current_step_enables[3] (SGPIO 36)"
    [37]="current_step_enables[2] (SGPIO 37)"
    [38]="current_step_enables[1] (SGPIO 38)"
    [39]="current_step_enables[0] (SGPIO 39)"
    [40]="Reserved (SGPIO 40)"
    [41]="Reserved (SGPIO 41)"
    [42]="current_step_pgoods[5] (SGPIO 42)"
    [43]="current_step_pgoods[4] (SGPIO 43)"
    [44]="current_step_pgoods[3] (SGPIO 44)"
    [45]="current_step_pgoods[2] (SGPIO 45)"
    [46]="current_step_pgoods[1] (SGPIO 46)"
    [47]="current_step_pgoods[0] (SGPIO 47)"
    [48]="FM_CPU0_SKTOCC_LVT3_N (SGPIO 48)"
    [49]="wBmcCpu0Thermtrip_n (SGPIO 49)"
    [50]="IRQ_CPU0_VRHOT_N (SGPIO 50)"
    [51]="wCPU0_MON_FAIL_PLD_LVC1_S_N (SGPIO 51)"
    [52]="IRQ_CPU0_MEM_VRHOT_N (SGPIO 52)"
    [53]="wCPU0_MEMHOT_OUT_LVC1_S_N (SGPIO 53)"
    [54]="FM_CPU0_PROC_ID0 (SGPIO 54)"
    [55]="FM_CPU0_PROC_ID1 (SGPIO 55)"
    [56]="wCPU_MISMATCH (SGPIO 56)"
    [57]="Constant 1'b1 (SGPIO 57)"
    [58]="FM_CPU1_SKTOCC_LVT3_N (SGPIO 58)"
    [59]="wBmcCpu1Thermtrip_n (SGPIO 59)"
    [60]="IRQ_CPU1_VRHOT_N (SGPIO 60)"
    [61]="wCPU1_MON_FAIL_PLD_LVC1_S_N (SGPIO 61)"
    [62]="IRQ_CPU1_MEM_VRHOT_N (SGPIO 62)"
    [63]="wCPU1_MEMHOT_OUT_LVC1_S_N (SGPIO 63)"
    [64]="FM_CPU1_PROC_ID0 (SGPIO 64)"
    [65]="FM_CPU1_PROC_ID1 (SGPIO 65)"
    [66]="wCPU_MISMATCH (SGPIO 66)"
    [67]="Spare (SGPIO 67)"
    [68]="Reserved (SGPIO 68)"
    [69]="Reserved (SGPIO 69)"
    [70]="Reserved (SGPIO 70)"
    [71]="Reserved (SGPIO 71)"
    [72]="M_GH_CPU1_FPGA_RESET_N (SGPIO 72)"
    [73]="M_EF_CPU1_FPGA_RESET_N (SGPIO 73)"
    [74]="M_CD_CPU1_FPGA_RESET_N (SGPIO 74)"
    [75]="M_AB_CPU1_FPGA_RESET_N (SGPIO 75)"
    [76]="M_GH_CPU0_FPGA_RESET_N (SGPIO 76)"
    [77]="M_EF_CPU0_FPGA_RESET_N (SGPIO 77)"
    [78]="M_CD_CPU0_FPGA_RESET_N (SGPIO 78)"
    [79]="M_AB_CPU0_FPGA_RESET_N (SGPIO 79)"
    [80]="M_GH_CPU1_RESET_N (SGPIO 80)"
    [81]="M_EF_CPU1_RESET_N (SGPIO 81)"
    [82]="M_CD_CPU1_RESET_N (SGPIO 82)"
    [83]="M_AB_CPU1_RESET_N (SGPIO 83)"
    [84]="M_GH_CPU0_RESET_N (SGPIO 84)"
    [85]="M_EF_CPU0_RESET_N (SGPIO 85)"
    [86]="M_CD_CPU0_RESET_N (SGPIO 86)"
    [87]="M_AB_CPU0_RESET_N (SGPIO 87)"
    [88]="iS3MCpu0CpldCrcError (SGPIO 88)"
    [89]="iS3MCpu1CpldCrcError (SGPIO 89)"
    [90]="Reserved (SGPIO 90)"
    [91]="Reserved (SGPIO 91)"
    [92]="Reserved (SGPIO 92)"
    [93]="Reserved (SGPIO 93)"
    [94]="Reserved (SGPIO 94)"
    [95]="Reserved (SGPIO 95)"
    [96]="FPGA_REV[0] (SGPIO 96)"
    [97]="FPGA_REV[1] (SGPIO 97)"
    [98]="FPGA_REV[2] (SGPIO 98)"
    [99]="FPGA_REV[3] (SGPIO 99)"
    [100]="FPGA_REV[4] (SGPIO 100)"
    [101]="FPGA_REV[5] (SGPIO 101)"
    [102]="FPGA_REV[6] (SGPIO 102)"
    [103]="FPGA_REV[7] (SGPIO 103)"
    [104]="Reserved (SGPIO 104)"
    [105]="(wMEM0_PWR_FLT || wMEM1_PWR_FLT) (SGPIO 105)"
    [106]="(wCPU0_MEM_PWR_FLT || wCPU1_MEM_PWR_FLT) (SGPIO 106)"
    [107]="PWRGD_P3V3_FF (SGPIO 107)"
    [108]="wPSU_PWR_FLT (SGPIO 108)"
    [109]="Reserved (SGPIO 109)"
    [110]="Reserved (SGPIO 110)"
    [111]="wPCH_PWR_FLT (SGPIO 111)"
    [112]="FM_CPU0_PKGID0 (SGPIO 112)"
    [113]="FM_CPU0_PKGID1 (SGPIO 113)"
    [114]="FM_CPU0_PKGID2 (SGPIO 114)"
    [115]="wBmcCpu0Memtrip_n (SGPIO 115)"
    [116]="FM_CPU1_PKGID0 (SGPIO 116)"
    [117]="FM_CPU1_PKGID1 (SGPIO 117)"
    [118]="FM_CPU1_PKGID2 (SGPIO 118)"
    [119]="wBmcCpu1Memtrip_n (SGPIO 119)"
    [120]="rail_alert_latch_byte_clear (SGPIO 120)"
    [121]="Reserved (SGPIO 121)"
    [122]="Reserved (SGPIO 122)"
    [123]="Reserved (SGPIO 123)"
    [124]="Reserved (SGPIO 124)"
    [125]="Reserved (SGPIO 125)"
    [126]="Reserved (SGPIO 126)"
    [127]="Reserved (SGPIO 127)"
)

# Function to find the GPIO chip with exactly 256 lines
find_gpiochip() {
    local gpiochip
    local gpio_lines
    while read -r line; do
        if [[ $line =~ (gpiochip[0-9]+).*"("([0-9]+)" lines)" ]]; then
            gpiochip="${BASH_REMATCH[1]}"
            gpio_lines="${BASH_REMATCH[2]}"
            if [[ $gpio_lines -eq 256 ]]; then
                echo "$gpiochip"
                return 0
            fi
        fi
    done < <(gpiodetect)
    return 1
}

# Function to reverse bits and convert to decimal
reverse_bits_and_convert() {
    local gpiochip="$1"
    local sgpio_lines=("${@:2}")
    local -a bits

    for i in "${sgpio_lines[@]}"; do
        if bit_value=$(gpioget "$gpiochip" "$i" 2>/dev/null); then
            bits+=("$bit_value")
        else
            echo "Error reading GPIO $i"
            bits+=("0")  # Assuming 0 if unable to read
        fi
    done

    # Reverse the bits array
    local reversed_bits=()
    for (( idx=${#bits[@]}-1 ; idx>=0 ; idx-- )) ; do
        reversed_bits+=( "${bits[idx]}" )
    done

    # Join bits and convert to decimal
    local binary_value
    binary_value=$(IFS=; echo "${reversed_bits[*]}")
    echo "$((2#$binary_value))"
}

# Function to query all GPIO states
query_all_gpio_states() {
    local gpiochip="$1"
    local -a even_gpio_lines
    for ((i=0; i<256; i+=2)); do
        even_gpio_lines+=("$i")
    done

    local index=0
    for gpio_line in "${even_gpio_lines[@]}"; do
        if [[ -n "${gpio_name_mapping[$index]}" ]]; then
            # Get the GPIO value for the current line
            if value=$(gpioget "$gpiochip" "$gpio_line" 2>/dev/null); then
                :
            else
                echo "Error reading GPIO $gpio_line"
                value="Error"
            fi
            # Display the SGPIO number, signal name, and its value
            #echo "SGPIO $gpio_line (${gpio_name_mapping[$index]}): $value"
        fi
        ((index++))
    done

    # Decode specific groups as decimal
    #echo "Decoding current_step_enables and current_step_pgoods in decimal:"
    # Adjusted SGPIO lines for current_step_enables and current_step_pgoods
    #echo "current_step_enables: $(reverse_bits_and_convert "$gpiochip" 34 35 36 37 38 39)"
    #echo "current_step_pgoods: $(reverse_bits_and_convert "$gpiochip" 42 43 44 45 46 47)"

    # Decode FPGA_REV[0..7] as decimal
    echo "Decoding FPGA_REV[0..7] to decimal:"
    echo "FPGA_REV: $(reverse_bits_and_convert "$gpiochip" 192 194 196 198 200 202 204 206)"
}

main() {
    gpiochip=$(find_gpiochip)
    if [[ -z "$gpiochip" ]]; then
        echo "No GPIO chip with 256 lines found."
        exit 1
    fi
    query_all_gpio_states "$gpiochip"
}

# Run the main function
main
