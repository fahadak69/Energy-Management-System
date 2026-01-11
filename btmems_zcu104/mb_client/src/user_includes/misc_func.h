typedef union {
    float value;
    int32_t bits;
} FloatUnion;

float combineRegistersToFloat(uint16_t *registers) {
    FloatUnion fu;

    // Assuming the first element (registers[0]) contains the most significant bits
    fu.bits = ((uint32_t)registers[0] << 16) | (uint32_t)registers[1];

    return fu.value;
}
