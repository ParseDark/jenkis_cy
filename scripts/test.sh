echo "start testing..... -> npx cypress run"
cypress run

echo "merge test report..... -> npx mochawesome-merge cypress/results/*.json > merge-report.json"
npx mochawesome-merge cypress/results/*.json > merge-report.json

echo "generator test report..... -> npx mochawesome-report-generator -o=./report -i merge-report.json"
npx mochawesome-report-generator -o=./report -i merge-report.json

