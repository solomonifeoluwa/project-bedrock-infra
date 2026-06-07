from diagrams import Diagram, Cluster, Edge
from diagrams.aws.network import (
    InternetGateway,
    ALB,
    NATGateway,
    PrivateSubnet,
    PublicSubnet,
)
from diagrams.aws.compute import EKS, Lambda
from diagrams.aws.database import RDS, Dynamodb
from diagrams.aws.storage import S3
from diagrams.aws.management import Cloudwatch
from diagrams.aws.security import SecretsManager
from diagrams.onprem.client import Users

graph_attr = {
    "fontsize": "14",
    "bgcolor": "white",
    "pad": "0.5",
    "splines": "ortho",
}

with Diagram(
    "Project Bedrock — AWS Architecture",
    filename="architecture",
    outformat="png",
    graph_attr=graph_attr,
    show=False,
):
    internet = Users("Internet / Users")

    with Cluster("AWS us-east-1"):

        with Cluster("VPC  10.0.0.0/16  (project-bedrock-vpc)"):

            with Cluster("Public Subnets\nus-east-1a / us-east-1b"):
                igw = InternetGateway("Internet Gateway")
                alb = ALB("ALB\n(AWS Load Balancer\nController)")
                nat = NATGateway("NAT Gateway")

            with Cluster("Private Subnets\nus-east-1a / us-east-1b"):

                with Cluster("EKS Cluster\nproject-bedrock-cluster  (k8s 1.34)"):
                    with Cluster("Namespace: retail-app"):
                        pods = EKS("Retail Store\nApp Pods")

                with Cluster("Managed Data Layer"):
                    mysql   = RDS("RDS MySQL 8.0\nproject-bedrock-mysql")
                    postgres = RDS("RDS PostgreSQL 17\nproject-bedrock-postgres")
                    dynamo  = Dynamodb("DynamoDB\nretail-products")

                secrets = SecretsManager("Secrets Manager\nDB Credentials")

        with Cluster("Serverless / Observability"):
            s3      = S3("S3 Bucket\nbedrock-assets-*")
            fn      = Lambda("Lambda\nbedrock-asset-processor")
            cw      = Cloudwatch("CloudWatch Logs\nControl Plane + App Logs")

    # ── Traffic flow ────────────────────────────────────────────────────────
    internet >> igw >> alb >> pods

    pods >> Edge(label="MySQL") >> mysql
    pods >> Edge(label="PostgreSQL") >> postgres
    pods >> Edge(label="DynamoDB") >> dynamo

    mysql   >> secrets
    postgres >> secrets

    nat >> Edge(style="dashed") >> pods

    # ── S3 → Lambda → CloudWatch ────────────────────────────────────────────
    s3  >> Edge(label="ObjectCreated\ntrigger") >> fn
    fn  >> Edge(label="logs") >> cw
    pods >> Edge(label="app logs", style="dashed") >> cw
