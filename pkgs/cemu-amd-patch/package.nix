{
  cemu,
  fetchFromGitHub,
  ...
}: cemu.overrideAttrs(old: {
  pname = "cemu-amd-patch";
  src = fetchFromGitHub {
    owner = "cemu-project";
    repo = "Cemu";
    # use the feedback_loop_layout branch
    rev = "5640d583449e1fc3af2c0d350d172802397b09f8";
    hash = "sha256-9lCqW/K6fWH5DNmlUV+vL3GoAl5HJei1lhqUwvYA0NI=";
  };
})