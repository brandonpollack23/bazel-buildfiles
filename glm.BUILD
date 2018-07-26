filegroup(
    name = "headers",
    srcs = glob(["**/*.hpp", "**/*.h"]),
)

filegroup(
    name = "inlines",
    srcs = glob(["**/*.inl"]),
)

cc_library(
    name = "glm",
    srcs = [":headers"],
    hdrs = [
        "glm/fwd.hpp",
        "glm/glm.hpp",
    ],
    textual_hdrs = [":inlines"],
    visibility = ["//visibility:public"],
)
