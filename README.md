# worker-mochi

[![RunPod](https://api.runpod.io/badge/rachfop/worker-mochi)](https://www.runpod.io/console/hub/rachfop/worker-mochi)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)


![worker-mochi hero image](https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=1200&q=80)

Generate videos using Mochi (Genmo) as an endpoint on RunPod. This worker automates loading the model, running inference across frames, and optionally uploading results via UploadThing.

Highlights
- Video generation using Mochi 1 by Genmo (https://github.com/genmoai/mochi)
- Automatic model loading and initialization on container start
- UploadThing integration for storing and sharing outputs
- Configurable generation parameters and VAE tiling to handle large frames

Demo

![example output preview](https://images.unsplash.com/photo-1518779578993-ec3579fee39f?auto=format&fit=crop&w=800&q=60)

Quick links
- API input reference — see "API" below
- Deployment — RunPod GitHub Integration
- Development & Contributing — .github/CONTRIBUTING.md

Getting started (Local / Dev)

1. Clone the repo

   git clone https://github.com/LearnCodeWithRam/worker-mochi-0.06.git

2. Build or pull the Docker image (if provided) or run locally in a Python venv
3. Configure secrets: RUNPOD_API_KEY, UPLOADTHING_ENDPOINT (if using upload), model paths
4. Start the worker (example)

   docker compose up --build

Example API (request body)

```json
{
  "input": {
    "positive_prompt": "a cat playing with yarn, cute, fluffy, detailed fur",
    "negative_prompt": "",
    "width": 848,
    "height": 480,
    "seed": 42,
    "steps": 40,
    "cfg": 6,
    "num_frames": 31,
    "vae": {
      "enable_vae_tiling": false,
      "tile_sample_min_width": 312,
      "tile_sample_min_height": 160,
      "tile_overlap_factor_width": 0.25,
      "tile_overlap_factor_height": 0.25,
      "auto_tile_size": false,
      "frame_batch_size": 8
    }
  }
}
```

Core Parameters

| Parameter         | Description                                                            | Default |
| ----------------- | ---------------------------------------------------------------------- | ------- |
| `positive_prompt` | Text description of what you want to generate                          | `""`    |
| `negative_prompt` | Text description of what you want to avoid in the generation           | `""`    |
| `width`           | Output video width in pixels                                           | `848`   |
| `height`          | Output video height in pixels                                          | `480`   |
| `seed`            | Random seed for reproducible results                                   | `1337`  |
| `steps`           | Number of denoising steps (higher = better quality, slower generation) | `40`    |
| `cfg`             | Classifier-free guidance scale (how closely to follow the prompt)      | `6`     |
| `num_frames`      | Number of frames to generate                                           | `31`    |

VAE Parameters

| Parameter                    | Description                                | Default |
| ---------------------------- | ------------------------------------------ | ------- |
| `enable_vae_tiling`          | Enable tiling for VAE decoding             | `false` |
| `tile_sample_min_width`      | Minimum tile width when tiling is enabled  | `312`   |
| `tile_sample_min_height`     | Minimum tile height when tiling is enabled | `160`   |
| `tile_overlap_factor_width`  | Overlap factor between tiles (width)       | `0.25`  |
| `tile_overlap_factor_height` | Overlap factor between tiles (height)      | `0.25`  |
| `auto_tile_size`             | Automatically determine tile size          | `false` |
| `frame_batch_size`           | Number of frames to process in parallel    | `8`     |

Usage examples
- Run a quick local job: curl -X POST http://localhost:8080/generate -H 'Content-Type: application/json' -d @input.json
- Output file: the worker produces a video file (MP4/WebM) and an optional preview GIF if configured.

Deployment

Deploy this worker on RunPod using the GitHub Integration:
https://docs.runpod.io/serverless/github-integration

Development

- See .github/CONTRIBUTING.md for development guidelines, testing, and how to run locally.
- Recommended: use a GPU-enabled environment for reasonable generation times.

Contributing

- Open issues for bugs or feature requests
- Send PRs against the default branch; include tests or a demo where possible
- Code style: follow the existing repository conventions

License

This project is released under the MIT License. See LICENSE for details.

Acknowledgements

- Mochi / Genmo — https://github.com/genmoai/mochi
- RunPod — https://www.runpod.io
