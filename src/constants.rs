// Copyright (C) 2017-2026 Smart Code OOD 203358507
// Yammbo Tv branding overrides.

pub const STREMIO_URL: &str = "https://tv.yammbo.com/app";
pub const APP_IDENTIFIER: &str = "com.yammbo.tv.service";
pub const APP_NAME: &str = "YammboTVService";
pub const APP_ICON: &[u8] = include_bytes!(concat!(env!("CARGO_MANIFEST_DIR"), "/icons/icon.png"));

pub const DESKTOP_FILE_PATH: &str = "/usr/share/applications";
pub const DESKTOP_FILE_NAME: &str = "com.yammbo.tv.service.desktop";
pub const AUTOSTART_CONFIG_PATH: &str = ".config/autostart";
pub const LAUNCH_AGENTS_PATH: &str = "Library/LaunchAgents";

// Yammbo Tv: el updater apunta SIEMPRE a nuestro dominio, nunca a Stremio, asi
// que el servicio no puede reemplazarse solo por el build original. El endpoint
// responde {versionDesc, version} y el descriptor lleva el sha256 del
// instalador, que el cliente verifica antes de ejecutarlo.
pub const UPDATE_ENDPOINT: [&str; 3] = [
    "https://tv.yammbo.com/updater/check?product=yammbo-tv-service",
    "https://tv.yammbo.com/updater/check?product=yammbo-tv-service",
    "https://tv.yammbo.com/updater/check?product=yammbo-tv-service",
];
