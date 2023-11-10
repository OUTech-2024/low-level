template<typename T>
concept dc_motor = requires(T x) {
  { x.set_power(0) } -> std::same_as<void>;
};
