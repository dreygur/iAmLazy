# -*- coding: utf-8 -*-
# pip install transformers diffusers accelerate -q
from diffusers import StableDiffusionPipeline
import torch

# Define the Model Path - https://huggingface.co/prompthero/midjourney-v4-diffusion
model_path = 'prompthero/midjourney-v4-diffusion'
pipe = StableDiffusionPipeline.from_pretrained(model_path , torch_dtype=torch.float16)

# !nvidia-smi

if torch.cuda.is_available():
  pipe = pipe.to("cuda")

device = "GPU 🔥" if torch.cuda.is_available() else "CPU 🥶"

base_prompt = "a beautiful anime cyborg girl with yellow eyes wearing a cat hoodie, pretty detailed eyes, full body. City background. posture by j scott campbell, perfect shading, soft studio lighting, ultra-realistic, photorealistic, octane render, cinematic lighting, hdr, in-frame, 4k, 8k, edge lighting"
prompt = "mdjrny-v4 style " + base_prompt

result = pipe(prompt,width = 512,height = 512)

image = result.images[0]

image.save("sd_img.png")