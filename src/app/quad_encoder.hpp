template<typename T>
concept quad_encoder = requires(T x) {
  { x.ticks() } -> std::signed_integral;
};
