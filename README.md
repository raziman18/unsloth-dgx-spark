## Unsloth (DGX Spark)

I have spent countless hours configuring unsloth to work on DGX Spark machine. Most of the guides or articles out there simply does not work or outdated. So here I've setup the whole framework to get you started.

#### 1. **Installation**
```
git clone https://github.com/raziman18/unsloth-dgx-spark.git && cd unsloth-dgx-spark
```

#### 2. **Create .env**
```
echo "UID=$(id -u)\nGID=$(id -g)" >> .env
```

#### 3. **Build**
```
docker compose build
```

#### 4. **Start**
```
docker compose up -d
```

#### 5. **Running Jupyter**

Now you can access jupyter notebook on http://localhost:8888
