def _glfw_cmake_impl(repository_ctx):
  if not repository_ctx.which("git"):
    bzl_fail("cmake dependency required to fetch glfw")
  if not repository_ctx.which("cmake"):
    bzl_fail("cmake dependency required to build glfw")

  repository_ctx.execute(["git", "clone", "https://github.com/glfw/glfw"], quiet=False)

  glfwdir = repository_ctx.path("glfw");
  if not glfwdir:
    bzl_fail("GLFW did not clone!")

  repository_ctx.execute(["cmake", glfwdir], quiet=False)

  makefile = repository_ctx.path("Makefile")
  if not makefile:
    bzl_fail("Make file not generated!")

  repository_ctx.execute(["make"], quiet=False)

  #TODO different files for sources on different platforms, constraints insde the cc_library
  repository_ctx.file(
      repository_ctx.path("BUILD"),
      content = """
cc_library(
    name = "glfw",
    srcs = ["src/libglfw.a"],
    hdrs = ["glfw/include/GLFW/glfw3.h"],
    include_prefix = "GLFW",
    visibility = ["//visibility:public"],
)
      """,
      executable = False,
    )

def bzl_fail(msg):
  """Output error when we fail to do something"""
  red = "\033[0;31m"
  no_color = "\033[0m"
  fail("\n%sGLFW Repo Error:%s %s\n" % (red, no_color, msg))

get_glfw = repository_rule(
    implementation = _glfw_cmake_impl,
    attrs = {}, # TODO add attrs for configurable stuff in glfw
)