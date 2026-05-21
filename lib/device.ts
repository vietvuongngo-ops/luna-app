export function getDeviceInfo() {
  if (typeof window === "undefined") {
    return {
      userAgent: "server",
      type: "desktop",
    };
  }

  const ua = navigator.userAgent.toLowerCase();
  const width = window.innerWidth;

  let type: "mobile" | "desktop" | "tablet" = "desktop";

  if (width < 768) type = "mobile";
  if (width >= 768 && width < 1024) type = "tablet";

  return {
    userAgent: ua,
    type,
  };
}
