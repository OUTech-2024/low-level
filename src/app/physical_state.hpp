template<typename T>
concept physical_state = requires(T x) {
  auto position = x.position();
  { position.x } -> std::floating_point;
  { position.y } -> std::floating_point;
  { x.direction() } -> std::floating_point;
  { x.speed() } -> std::floating_point;
  { x.update_ticks(0, 0); } -> std::same_as<void>;
};
